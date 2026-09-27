import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/scan_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../state/providers.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_brand.dart';

enum _SetupStep { roomScan, detected, layout, sections }

class SetupFlowScreen extends ConsumerStatefulWidget {
  const SetupFlowScreen({
    super.key,
    this.manual = false,
    this.editLayout = false,
    this.newSpace = false,
  });
  final bool manual;
  final bool editLayout;
  final bool newSpace;

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
    final currentLayout = _layouts.indexWhere(
      (option) => option.$1 == setup.layoutLabel,
    );
    if (currentLayout >= 0) _selectedLayout = currentLayout;
    if (widget.newSpace) {
      _step = _SetupStep.roomScan;
    } else if (widget.editLayout) {
      _step = _SetupStep.layout;
    } else if (widget.manual) {
      _step = _SetupStep.detected;
    } else if (setup.isComplete) {
      _step = _SetupStep.sections;
    } else {
      _step = _SetupStep.roomScan;
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop:
        _step == _SetupStep.roomScan ||
        (_step == _SetupStep.detected && widget.manual) ||
        (_step == _SetupStep.layout && widget.editLayout),
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
      bottomNavigationBar: _step == _SetupStep.detected
          ? _reviewFooter()
          : null,
    ),
  );

  Widget _reviewFooter() {
    final manual = widget.manual || _capturedRoom == null;
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!manual && _acceptedContainerIds.isEmpty) ...[
                const Text('Confirm at least one storage spot to continue.'),
                const SizedBox(height: AppSpacing.sm),
              ],
              PrimaryActionButton(
                key: const Key('continue-detected'),
                label: manual ? 'Choose a layout' : 'Save confirmed storage',
                onPressed: _savingReview
                    ? null
                    : manual
                    ? () => setState(() => _step = _SetupStep.layout)
                    : _acceptedContainerIds.isEmpty
                    ? null
                    : _saveReviewedRoom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ShelfRoom? _capturedRoom;
  final List<ShelfContainer> _reviewContainers = [];
  final Set<String> _acceptedContainerIds = {};
  bool _scanBusy = false;
  bool _savingReview = false;
  String? _scanError;

  Widget _roomScan() => ListView(
    key: const ValueKey('room-scan'),
    padding: const EdgeInsets.all(AppSpacing.lg),
    children: [
      const ShelfPageHeader(
        eyebrow: 'Room capture',
        title: 'Scanning workspace',
        subtitle:
            'Move slowly to map the room. Point at each storage unit and tap Mark storage in the camera.',
        showLogo: false,
      ),
      const SizedBox(height: AppSpacing.md),
      PrimaryActionButton(
        key: const Key('finish-room-scan'),
        label: _scanBusy ? 'Scanning…' : 'Start room scan',
        onPressed: _scanBusy ? null : _startRoomScan,
      ),
      const SizedBox(height: AppSpacing.md),
      const _RoomScanIllustration(),
      const SizedBox(height: AppSpacing.sm),
      Text(
        'Example of what to mark in the camera',
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: AppSpacing.md),
      HardShadowCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CAPTURE STATUS',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _scanError ??
                  (_scanBusy
                      ? 'Camera is open. Finish or cancel the capture there.'
                      : 'Your camera opens when you start. Only actual observations will appear for review.'),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('CANCEL'),
      ),
    ],
  );

  Future<void> _startRoomScan() async {
    setState(() {
      _scanBusy = true;
      _scanError = null;
    });
    try {
      final room = await ref.read(scanServiceProvider).scanRoom();
      if (!mounted) return;
      _capturedRoom = room;
      _reviewContainers.clear();
      _acceptedContainerIds.clear();
      for (final unit in room.storage) {
        final container = ShelfContainer(
          id: 'container-${DateTime.now().microsecondsSinceEpoch}-${_reviewContainers.length}',
          name: unit.name.isEmpty
              ? '${unit.kind} ${_reviewContainers.length + 1}'
              : unit.name,
          type: unit.kind,
          geometryJson: jsonEncode(unit.toJson()),
        );
        _reviewContainers.add(container);
      }
      setState(() => _step = _SetupStep.detected);
    } on ScanFailure catch (error) {
      if (mounted && error.code != 'cancelled') {
        setState(() => _scanError = error.message);
      }
    } catch (error) {
      if (mounted) setState(() => _scanError = error.toString());
    } finally {
      if (mounted) setState(() => _scanBusy = false);
    }
  }

  Widget _detectedSpaces() {
    final state = ref.watch(setupProvider);
    final manual = widget.manual || _capturedRoom == null;
    final containers = manual
        ? [if (state.container != null) state.container!]
        : _reviewContainers;
    return ListView(
      key: const ValueKey('detected-spaces'),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 130),
      children: [
        ShelfPageHeader(
          eyebrow: manual ? 'Manual setup' : 'Room scan complete',
          title: manual ? 'Storage space' : 'Room captured',
          subtitle: manual
              ? 'Review this container before choosing its layout.'
              : 'Name the storage you marked, then choose what to keep.',
        ),
        const SizedBox(height: AppSpacing.md),
        HardShadowCard(
          color: Theme.of(context).colorScheme.tertiary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SCAN SUMMARY',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                manual
                    ? '✓ Container created manually'
                    : '${_capturedRoom!.surfaces.length} room surfaces • ${_capturedRoom!.storage.length} storage marks',
              ),
              if (!manual) const Text('Room measurements are estimates.'),
              Text(
                manual
                    ? '✓ Ready for layout setup'
                    : 'Only storage you confirm will be saved.',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (!manual) ...[
          const HardShadowCard(
            child: Text(
              '1. Tap REVIEW to give a mark a name and type.\n'
              '2. Tap CONFIRM for each storage spot to keep.\n'
              '3. Save your choices to set up sections.',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Row(
          children: [
            Expanded(
              child: Text(
                'STORAGE TO REVIEW',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              manual
                  ? 'MANUAL'
                  : '${_acceptedContainerIds.length} / ${containers.length} CONFIRMED',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (containers.isEmpty)
          const HardShadowCard(
            child: Text(
              'No storage was marked. You can go back to scan again or add a storage spot here.',
            ),
          ),
        for (final container in containers) ...[
          _DetectionCard(
            name: container.name,
            detail: manual
                ? 'Manual entry'
                : container.geometryJson == null
                ? 'Added by you'
                : (jsonDecode(container.geometryJson!) as Map)['source'] ==
                      'manual_ar'
                ? 'Marked in the room camera'
                : 'Suggested by the room camera',
            color: _acceptedContainerIds.contains(container.id) || manual
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            status: manual || _acceptedContainerIds.contains(container.id)
                ? 'CONFIRMED'
                : 'REVIEW',
            dashed: !manual && !_acceptedContainerIds.contains(container.id),
            onTap: () => _renameContainer(container),
          ),
          if (!manual)
            Row(
              children: [
                TextButton(
                  onPressed: () => setState(() {
                    if (!_acceptedContainerIds.add(container.id)) {
                      _acceptedContainerIds.remove(container.id);
                    }
                  }),
                  child: Text(
                    _acceptedContainerIds.contains(container.id)
                        ? 'UNCONFIRM'
                        : 'CONFIRM',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: () => setState(() {
                    _reviewContainers.removeWhere(
                      (value) => value.id == container.id,
                    );
                    _acceptedContainerIds.remove(container.id);
                  }),
                  child: const Text('REMOVE'),
                ),
              ],
            ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (!manual)
          TextButton(
            onPressed: _addManualContainer,
            child: const Text('+ ADD STORAGE I MISSED'),
          ),
      ],
    );
  }

  Future<void> _addManualContainer() async {
    final id = 'container-${DateTime.now().microsecondsSinceEpoch}';
    final container = ShelfContainer(
      id: id,
      name: 'New Cabinet',
      type: 'Cabinet',
    );
    setState(() => _reviewContainers.add(container));
    await _renameContainer(container);
  }

  Future<void> _saveReviewedRoom() async {
    final room = _capturedRoom;
    if (room == null || _savingReview) return;
    if (room.surfaces.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No room surfaces were captured. Scan again or set up manually.',
          ),
        ),
      );
      return;
    }
    final accepted = _reviewContainers
        .where((value) => _acceptedContainerIds.contains(value.id))
        .toList();
    if (accepted.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirm a container or add one manually.'),
        ),
      );
      return;
    }
    setState(() => _savingReview = true);
    try {
      await ref.read(setupProvider.notifier).saveScannedRoom(room, accepted);
      if (mounted) setState(() => _step = _SetupStep.layout);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _savingReview = false);
    }
  }

  Future<void> _renameContainer(ShelfContainer container) async {
    final controller = TextEditingController(text: container.name);
    var type = container.type;
    final updated = await showDialog<ShelfContainer>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit container'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Container name'),
              ),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: [
                  for (final option in const [
                    'Cabinet',
                    'Shelf',
                    'Rack',
                    'Drawer',
                    'Storage',
                    'Unknown',
                  ])
                    DropdownMenuItem(value: option, child: Text(option)),
                ],
                onChanged: (value) {
                  if (value != null) setDialogState(() => type = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            FilledButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  Navigator.pop(
                    context,
                    container.copyWith(
                      name: controller.text.trim(),
                      type: type,
                    ),
                  );
                }
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
    if (updated != null) {
      if (_capturedRoom != null && !widget.manual) {
        setState(() {
          final index = _reviewContainers.indexWhere(
            (value) => value.id == updated.id,
          );
          if (index >= 0) _reviewContainers[index] = updated;
        });
      } else {
        await ref.read(setupProvider.notifier).saveContainer(updated);
      }
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

  Future<void> _useLayout() async {
    final option = _layouts[_selectedLayout];
    var count = option.$2;
    if (_selectedLayout == 5) {
      final controller = TextEditingController(
        text:
            '${ref.read(setupProvider).sections.isEmpty ? 3 : ref.read(setupProvider).sections.length}',
      );
      final customCount = await showDialog<int>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Custom layout'),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Number of sections (1–12)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            FilledButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                if (value != null && value >= 1 && value <= 12) {
                  Navigator.pop(context, value);
                }
              },
              child: const Text('USE'),
            ),
          ],
        ),
      );
      if (customCount == null) return;
      count = customCount;
    }
    try {
      await ref.read(setupProvider.notifier).chooseLayout(option.$1, count);
      if (mounted) {
        setState(() => _step = _SetupStep.sections);
      }
    } on StateError catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
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
          subtitle:
              'Choose where an item belongs. You can add items to other sections later.',
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
                      'SECTIONS WITH ITEMS',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  _StatusPill(
                    label:
                        '${state.sections.where((s) => state.countForSection(s.id) > 0).length} / ${state.sections.length}',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              LinearProgressIndicator(
                value: state.sections.isEmpty
                    ? 0
                    : state.sections
                              .where((s) => state.countForSection(s.id) > 0)
                              .length /
                          state.sections.length,
                minHeight: 10,
                color: Color(0xFFCCFF00),
                backgroundColor: Color(0xFFF5F0EF),
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (var index = 0; index < state.sections.length; index++) ...[
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CandidatePreviewScreen(section: state.sections[index]),
              ),
            ),
            child: HardShadowCard(
              color: index == 0
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                              state.countForSection(state.sections[index].id) ==
                                      0
                                  ? 'Tap to add items here'
                                  : '${state.countForSection(state.sections[index].id)} items saved • tap to add more',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward, size: 22),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton.icon(
                    onPressed: () => _renameSection(state.sections[index]),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('RENAME SECTION'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.sm),
        PrimaryActionButton(
          key: const Key('scan-section'),
          label: first == null ? 'Finish setup' : 'Add items to ${first.name}',
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
          child: const Text('DONE FOR NOW'),
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
    if (name != null && name.isNotEmpty) {
      await ref.read(setupProvider.notifier).renameSection(section.id, name);
    }
  }
}

class CandidatePreviewScreen extends ConsumerStatefulWidget {
  const CandidatePreviewScreen({super.key, required this.section});
  final ShelfSection section;

  @override
  ConsumerState<CandidatePreviewScreen> createState() =>
      _CandidatePreviewScreenState();
}

class _CandidatePreviewScreenState
    extends ConsumerState<CandidatePreviewScreen> {
  bool _busy = false;

  Future<void> _captureItems() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final suggestions = await ref.read(scanServiceProvider).scanItems();
      for (final suggestion in suggestions) {
        await ref
            .read(setupProvider.notifier)
            .addCandidate(
              sectionId: widget.section.id,
              name: suggestion.name,
              identifier: suggestion.identifier,
              confidence: suggestion.confidence,
              source: suggestion.source,
            );
      }
      if (mounted && suggestions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No readable labels found. Add the item manually.'),
          ),
        );
      }
    } on ScanFailure catch (error) {
      if (mounted && error.code != 'cancelled') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _edit([ScanCandidate? candidate]) async {
    final name = TextEditingController(text: candidate?.name ?? '');
    final category = TextEditingController(
      text: candidate?.category ?? 'Equipment',
    );
    final model = TextEditingController(text: candidate?.model ?? '');
    final identifier = TextEditingController(text: candidate?.identifier ?? '');
    final form = GlobalKey<FormState>();
    final save = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(candidate == null ? 'Add an item' : 'Edit candidate'),
        content: Form(
          key: form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Item name'),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Enter an item name'
                      : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: category,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: model,
                  decoration: const InputDecoration(labelText: 'Model'),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: identifier,
                  decoration: const InputDecoration(
                    labelText: 'Identifier / serial',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () {
              if (form.currentState!.validate()) Navigator.pop(context, true);
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
    if (save == true) {
      final notifier = ref.read(setupProvider.notifier);
      if (candidate == null) {
        await notifier.addCandidate(
          sectionId: widget.section.id,
          name: name.text,
          category: category.text,
          model: model.text,
          identifier: identifier.text,
        );
      } else {
        await notifier.updateCandidate(
          candidate.id,
          name: name.text,
          category: category.text,
          model: model.text,
          identifier: identifier.text,
          state: 'accepted',
        );
      }
    }
  }

  Future<void> _confirm() async {
    if (_busy) return;
    setState(() => _busy = true);
    final saved = await ref
        .read(setupProvider.notifier)
        .confirmCandidates(widget.section.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          saved == 0
              ? 'No new items to save.'
              : '$saved items saved to ${widget.section.name}.',
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final candidates = ref
        .watch(setupProvider)
        .candidates
        .where(
          (candidate) =>
              candidate.sectionId == widget.section.id &&
              candidate.state != 'confirmed' &&
              candidate.state != 'rejected',
        )
        .toList();
    final ready = candidates.where((candidate) => candidate.accepted).length;
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const ShelfBackButton(label: 'Back to sections'),
              const SizedBox(height: AppSpacing.md),
              ShelfPageHeader(
                eyebrow: widget.section.name,
                title: 'Review items',
                subtitle:
                    'Scan a label, then check each suggested name before saving.',
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryActionButton(
                label: _busy ? 'Opening camera…' : 'Scan items',
                onPressed: _busy ? null : _captureItems,
              ),
              const SizedBox(height: AppSpacing.md),
              const HardShadowCard(
                child: Text(
                  'Camera text can be wrong. Edit any name that does not match the real item. Only items marked ready will be saved.',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${candidates.length} SUGGESTED ITEMS',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(child: _StatusPill(label: '$ready READY')),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: _StatusPill(
                            label: '${candidates.length - ready} NEED REVIEW',
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (candidates.isEmpty)
                const HardShadowCard(
                  child: Text(
                    'No suggestions yet. Scan a label or add an item yourself.',
                  ),
                ),
              for (final candidate in candidates) ...[
                HardShadowCard(
                  dashed: !candidate.accepted,
                  color: candidate.accepted
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  candidate.source == 'manual'
                                      ? 'Added by you'
                                      : 'Camera suggestion • check the name',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                          _StatusPill(
                            label: candidate.accepted ? 'READY' : 'REVIEW',
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          if (!candidate.accepted)
                            TextButton(
                              onPressed: () => ref
                                  .read(setupProvider.notifier)
                                  .updateCandidate(
                                    candidate.id,
                                    state: 'accepted',
                                  ),
                              child: const Text('USE THIS'),
                            ),
                          TextButton(
                            onPressed: () => _edit(candidate),
                            child: const Text('EDIT DETAILS'),
                          ),
                          TextButton(
                            onPressed: () => ref
                                .read(setupProvider.notifier)
                                .updateCandidate(
                                  candidate.id,
                                  state: 'rejected',
                                ),
                            child: const Text('DISCARD'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              InkWell(
                onTap: () => _edit(),
                child: const HardShadowCard(
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
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryActionButton(
                label: _busy ? 'Saving…' : 'Save $ready reviewed items',
                onPressed: _busy || ready == 0 ? null : _confirm,
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('REVIEW THESE LATER'),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
            label: 'CABINET',
            width: 132,
            height: 174,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Positioned(
          right: 28,
          bottom: 72,
          child: _DetectedObject(
            label: 'SHELF',
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
