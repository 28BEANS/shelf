import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../state/providers.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_brand.dart';

enum _SetupStep { roomScan, detected, layout, sections }

class SetupFlowScreen extends ConsumerStatefulWidget {
  const SetupFlowScreen({super.key, this.manual = false});
  final bool manual;

  @override
  ConsumerState<SetupFlowScreen> createState() => _SetupFlowScreenState();
}

class _SetupFlowScreenState extends ConsumerState<SetupFlowScreen> {
  late _SetupStep _step;
  int _selectedLayout = 2;

  static const _layouts = [
    ('One section', 1),
    ('Two sections', 2),
    ('Three sections', 3),
    ('Four shelves', 4),
    ('Three drawers', 3),
    ('Custom', 3),
  ];

  @override
  void initState() {
    super.initState();
    final setup = ref.read(setupProvider);
    if (setup.isComplete) {
      _step = _SetupStep.sections;
    } else if (widget.manual) {
      _step = _SetupStep.detected;
    } else {
      _step = _SetupStep.roomScan;
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop:
        _step == _SetupStep.roomScan ||
        (_step == _SetupStep.detected && widget.manual),
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) setState(() => _step = _SetupStep.values[_step.index - 1]);
    },
    child: Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            child: switch (_step) {
              _SetupStep.roomScan => _roomScan(),
              _SetupStep.detected => _detectedSpaces(),
              _SetupStep.layout => _chooseLayout(),
              _SetupStep.sections => _selectSection(),
            },
          ),
        ),
      ),
    ),
  );

  Widget _roomScan() => ListView(
    key: const ValueKey('room-scan'),
    padding: const EdgeInsets.all(AppSpacing.lg),
    children: [
      const ShelfPageHeader(
        eyebrow: 'Room capture',
        title: 'Scanning workspace',
        subtitle: 'Move slowly and capture every wall.',
        showLogo: false,
      ),
      const SizedBox(height: AppSpacing.md),
      const _RoomScanIllustration(),
      const SizedBox(height: AppSpacing.md),
      HardShadowCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'SCAN PROGRESS',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const _StatusPill(label: 'ACTIVE', color: Color(0xFFB5EAD7)),
              ],
            ),
            const SizedBox(height: AppSpacing.listItem),
            const LinearProgressIndicator(
              value: .74,
              minHeight: 10,
              backgroundColor: Color(0xFFF5F0EF),
              color: Color(0xFFCCFF00),
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
            const SizedBox(height: AppSpacing.listItem),
            const _ScanLine(label: '✓ Walls captured', value: '3 / 4'),
            const _ScanLine(label: '□ Storage objects found', value: '3'),
            const _ScanLine(label: '△ Area remaining', value: '1'),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            flex: 2,
            child: PrimaryActionButton(
              key: const Key('finish-room-scan'),
              label: 'Finish scan',
              onPressed: _finishRoomScan,
            ),
          ),
        ],
      ),
    ],
  );

  Future<void> _finishRoomScan() async {
    final results = await ref.read(scanServiceProvider).scanContainers();
    if (!mounted) return;
    ref.read(setupProvider.notifier).saveContainer(results.first);
    setState(() => _step = _SetupStep.detected);
  }

  Widget _detectedSpaces() {
    final state = ref.watch(setupProvider);
    final container =
        state.container ??
        const ShelfContainer(
          id: 'manual',
          name: 'New Cabinet',
          type: 'Cabinet',
        );
    return ListView(
      key: const ValueKey('detected-spaces'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const ShelfPageHeader(
          eyebrow: 'Room scan complete',
          title: 'Room captured',
          subtitle: 'Review Shelf’s suggestions before setup.',
        ),
        const SizedBox(height: AppSpacing.md),
        HardShadowCard(
          color: Theme.of(context).colorScheme.tertiary,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'SCAN SUMMARY',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  _StatusPill(label: 'COMPLETE'),
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              Text('✓ 3 possible storage spaces'),
              Text('✓ 1 table detected'),
              Text('✓ Room scan saved locally'),
              SizedBox(height: AppSpacing.sm),
              LinearProgressIndicator(
                value: 1,
                minHeight: 10,
                color: Color(0xFFCCFF00),
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: Text(
                'DETECTED SPACES',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              widget.manual ? 'MANUAL' : '2 / 3 CONFIRMED',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _DetectionCard(
          name: container.name,
          detail: widget.manual ? 'Manual entry' : 'Confirmed',
          color: Theme.of(context).colorScheme.primary,
          status: 'CONFIRMED',
          onTap: () => _renameContainer(container),
        ),
        if (!widget.manual) ...[
          const SizedBox(height: AppSpacing.sm),
          const _DetectionCard(
            name: 'Shelf near the west wall',
            detail: 'Ready to confirm',
            status: 'REVIEW',
            dashed: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          _DetectionCard(
            name: 'Drawer unit by the door',
            detail: 'Needs review',
            status: 'REVIEW',
            dashed: true,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        PrimaryActionButton(
          key: const Key('continue-detected'),
          label: 'Continue',
          onPressed: () => setState(() => _step = _SetupStep.layout),
        ),
      ],
    );
  }

  Future<void> _renameContainer(ShelfContainer container) async {
    final controller = TextEditingController(text: container.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename container'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Container name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name != null && name.isNotEmpty) {
      ref
          .read(setupProvider.notifier)
          .saveContainer(container.copyWith(name: name));
    }
  }

  Widget _chooseLayout() {
    final container = ref.watch(setupProvider).container;
    return ListView(
      key: const ValueKey('choose-layout'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        ShelfPageHeader(
          eyebrow: 'Setup • 2 of 3',
          title: 'Choose a layout',
          subtitle: container?.name ?? 'Equipment Cabinet',
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'How is this cabinet divided?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Pick the closest structure. You can rename sections later.',
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.22,
          ),
          itemCount: _layouts.length,
          itemBuilder: (context, index) => _LayoutTile(
            key: Key('layout-${_layouts[index].$2}-$index'),
            label: _layouts[index].$1,
            lines: _layouts[index].$2,
            selected: _selectedLayout == index,
            custom: index == 5,
            onTap: () => setState(() => _selectedLayout = index),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PrimaryActionButton(
          key: const Key('use-layout'),
          label: 'Use this layout',
          onPressed: _useLayout,
        ),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL SETUP'),
          ),
        ),
      ],
    );
  }

  void _useLayout() {
    final option = _layouts[_selectedLayout];
    ref.read(setupProvider.notifier).chooseLayout(option.$1, option.$2);
    setState(() => _step = _SetupStep.sections);
  }

  Widget _selectSection() {
    final state = ref.watch(setupProvider);
    final first = state.sections.isEmpty ? null : state.sections.first;
    return ListView(
      key: const ValueKey('select-section'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        ShelfPageHeader(
          eyebrow: state.container?.name ?? 'Equipment Cabinet',
          title: 'Select a section',
          subtitle: 'Scan one section at a time.',
          showLogo: false,
        ),
        const SizedBox(height: AppSpacing.md),
        HardShadowCard(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'SECTIONS SCANNED',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  _StatusPill(label: '0 / ${state.sections.length}'),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const LinearProgressIndicator(
                value: .03,
                minHeight: 10,
                color: Color(0xFFCCFF00),
                backgroundColor: Color(0xFFF5F0EF),
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        HardShadowCard(
          child: Column(
            children: [
              for (var index = 0; index < state.sections.length; index++) ...[
                InkWell(
                  onTap: () => _renameSection(state.sections[index]),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFFF5F0EF),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      state.sections[index].name.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                if (index != state.sections.length - 1)
                  const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (var index = 0; index < state.sections.length; index++) ...[
          HardShadowCard(
            color: index == 0
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.sections[index].name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        index == 0 ? 'Ready to scan' : 'Not scanned',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
                _StatusPill(
                  label: index == 0 ? 'SCAN' : 'PENDING',
                  color: index == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.sm),
        PrimaryActionButton(
          key: const Key('scan-section'),
          label: first == null ? 'Finish setup' : 'Scan ${first.name}',
          onPressed: first == null
              ? () => Navigator.pop(context)
              : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CandidatePreviewScreen(section: first),
                  ),
                ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextButton(
          key: const Key('finish-setup'),
          onPressed: () => Navigator.pop(context),
          child: const Text('FINISH SETUP WITHOUT SCANNING'),
        ),
      ],
    );
  }

  Future<void> _renameSection(ShelfSection section) async {
    final controller = TextEditingController(text: section.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename section'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Section name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name != null && name.isNotEmpty) {
      ref.read(setupProvider.notifier).renameSection(section.id, name);
    }
  }
}

class CandidatePreviewScreen extends ConsumerWidget {
  const CandidatePreviewScreen({super.key, required this.section});
  final ShelfSection section;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    body: ShelfMobileRail(
      child: SafeArea(
        child: FutureBuilder<List<ScanCandidate>>(
          future: ref.read(scanServiceProvider).scanItems(section.id),
          builder: (context, snapshot) {
            final items = snapshot.data;
            if (items == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                ShelfPageHeader(
                  eyebrow: section.name,
                  title: 'Review items',
                  subtitle: 'Confirm Shelf’s suggestions.',
                ),
                const SizedBox(height: AppSpacing.md),
                HardShadowCard(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${items.length} POSSIBLE ITEMS FOUND',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const _StatusPill(label: 'REVIEW'),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                for (var index = 0; index < items.length; index++) ...[
                  _ReviewItemCard(
                    candidate: items[index],
                    review: index == items.length - 1,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                const HardShadowCard(
                  child: Row(
                    children: [
                      Text(
                        '+ ADD A MISSED ITEM',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryActionButton(
                  label: 'Confirm inventory',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class _RoomScanIllustration extends StatelessWidget {
  const _RoomScanIllustration();

  @override
  Widget build(BuildContext context) => Container(
    height: 430,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      border: Border.all(width: 3),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(color: Color(0xFF1A1A1A), offset: Offset(6, 7)),
      ],
    ),
    child: Stack(
      children: [
        const Positioned(left: 20, top: 20, child: _Corner()),
        const Positioned(
          right: 20,
          top: 20,
          child: RotatedBox(quarterTurns: 1, child: _Corner()),
        ),
        const Positioned(
          left: 20,
          bottom: 20,
          child: RotatedBox(quarterTurns: 3, child: _Corner()),
        ),
        const Positioned(
          right: 20,
          bottom: 20,
          child: RotatedBox(quarterTurns: 2, child: _Corner()),
        ),
        Positioned(
          left: 36,
          bottom: 82,
          child: _DetectedObject(
            label: 'CABINET • 92%',
            width: 132,
            height: 174,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          right: 28,
          bottom: 72,
          child: _DetectedObject(
            label: 'SHELF • 86%',
            width: 112,
            height: 142,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          top: 220,
          child: Divider(color: Color(0xFFCCFF00), thickness: 3),
        ),
        const Center(child: Icon(Icons.gps_fixed, size: 48)),
      ],
    ),
  );
}

class _Corner extends StatelessWidget {
  const _Corner();
  @override
  Widget build(BuildContext context) => Container(
    width: 36,
    height: 36,
    decoration: const BoxDecoration(
      border: Border(left: BorderSide(width: 4), top: BorderSide(width: 4)),
    ),
  );
}

class _DetectedObject extends StatelessWidget {
  const _DetectedObject({
    required this.label,
    required this.width,
    required this.height,
    required this.color,
  });
  final String label;
  final double width;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFCCFF00), width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusPill(label: label, color: const Color(0xFFCCFF00)),
        const SizedBox(height: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ScanLine extends StatelessWidget {
  const _ScanLine({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.labelSmall),
      ],
    ),
  );
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, this.color = Colors.white});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 2),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
    ),
  );
}

class _DetectionCard extends StatelessWidget {
  const _DetectionCard({
    required this.name,
    required this.detail,
    required this.status,
    this.color = Colors.white,
    this.dashed = false,
    this.onTap,
  });
  final String name;
  final String detail;
  final String status;
  final Color color;
  final bool dashed;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => HardShadowCard(
    color: color,
    dashed: dashed,
    onTap: onTap,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              Text(detail, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
        _StatusPill(
          label: status,
          color: status == 'CONFIRMED'
              ? Theme.of(context).colorScheme.tertiary
              : Colors.white,
        ),
      ],
    ),
  );
}

class _LayoutTile extends StatelessWidget {
  const _LayoutTile({
    super.key,
    required this.label,
    required this.lines,
    required this.selected,
    required this.custom,
    required this.onTap,
  });
  final String label;
  final int lines;
  final bool selected;
  final bool custom;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).colorScheme.primary : Colors.white,
        border: Border.all(width: 3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Color(0xFF1A1A1A), offset: Offset(5, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0EF),
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: custom
                  ? const Center(child: Icon(Icons.add, size: 34))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (var index = 1; index < lines; index++)
                          const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 2,
                            color: Color(0xFF1A1A1A),
                          ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.toUpperCase(),
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ),
  );
}

class _ReviewItemCard extends StatelessWidget {
  const _ReviewItemCard({required this.candidate, required this.review});
  final ScanCandidate candidate;
  final bool review;
  @override
  Widget build(BuildContext context) => HardShadowCard(
    dashed: review,
    color: review
        ? Theme.of(context).colorScheme.secondary
        : (candidate.confidence > .92
              ? Theme.of(context).colorScheme.primary
              : Colors.white),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                candidate.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${(candidate.confidence * 100).round()}% confidence',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        _StatusPill(
          label: review ? 'REVIEW' : 'STORED',
          color: review
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.tertiary,
        ),
      ],
    ),
  );
}
