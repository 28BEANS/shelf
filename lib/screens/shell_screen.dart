import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../state/providers.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_bottom_navigation.dart';
import '../widgets/shelf_brand.dart';
import '../widgets/shelf_illustration.dart';
import 'inventory_screens.dart';
import 'setup_flow_screen.dart';

class ShelfShell extends ConsumerStatefulWidget {
  const ShelfShell({super.key});

  @override
  ConsumerState<ShelfShell> createState() => _ShelfShellState();
}

class _ShelfShellState extends ConsumerState<ShelfShell> {
  int _index = 0;

  Future<void> _openSetup({bool manual = false}) async {
    final setup = ref.read(setupProvider);
    if (setup.workspace == null) {
      final name = TextEditingController();
      final description = TextEditingController();
      final form = GlobalKey<FormState>();
      final create = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Create workspace'),
          content: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Workspace name',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Enter a workspace name'
                      : null,
                ),
                const SizedBox(height: AppSpacing.sm),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                  ),
                ),
              ],
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
              child: const Text('CREATE'),
            ),
          ],
        ),
      );
      if (create != true) {
        return;
      }
      await ref
          .read(setupProvider.notifier)
          .saveWorkspace(name.text, description.text);
    }
    if (manual) {
      await ref
          .read(setupProvider.notifier)
          .saveContainer(
            ShelfContainer(
              id: 'manual-${DateTime.now().microsecondsSinceEpoch}',
              name: 'New Cabinet',
              type: 'Cabinet',
            ),
          );
    }
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SetupFlowScreen(manual: manual, newSpace: !manual),
      ),
    );
    if (mounted) setState(() => _index = 0);
  }

  @override
  Widget build(BuildContext context) {
    final setup = ref.watch(setupProvider);
    if (setup.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (setup.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Could not open local inventory: ${setup.error}'),
        ),
      );
    }
    final pages = [
      _HomePage(onScan: () => setState(() => _index = 1)),
      _ScanPage(
        onScan: () => _openSetup(),
        onManual: () => _openSetup(manual: true),
        onExisting: () {
          final container = ref.read(setupProvider).container;
          if (container != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ContainerOverviewScreen(containerId: container.id),
              ),
            );
          }
        },
      ),
      const InventorySearchPage(),
    ];
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: IndexedStack(index: _index, children: pages),
        ),
      ),
      bottomNavigationBar: ShelfBottomNavigation(
        currentIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
      ),
    );
  }
}

class _HomePage extends ConsumerWidget {
  const _HomePage({required this.onScan});
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        104,
      ),
      children: [
        const ShelfPageHeader(
          eyebrow: 'Friday, Sep 5',
          title: 'Your Spaces',
          subtitle: 'Open a space or continue setup.',
        ),
        const SizedBox(height: AppSpacing.md),
        if (state.workspace != null && state.containers.isNotEmpty)
          HardShadowCard(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.workspace!.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const _PillLabel(label: 'READY', color: Color(0xFFB5EAD7)),
                  ],
                ),
                Text(state.isComplete ? 'Ready to use' : 'Continue setup'),
                const SizedBox(height: AppSpacing.md),
                const ShelfIllustration(height: 148),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _Metric(
                        value: '${state.containers.length}',
                        label: 'containers',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _Metric(
                        value: '${state.allSections.length}',
                        label: 'sections',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _Metric(
                        value: '${state.items.length}',
                        label: 'items',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryActionButton(
                  label: 'Open space',
                  onPressed: state.container == null
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ContainerOverviewScreen(
                              containerId: state.container!.id,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          )
        else
          HardShadowCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'No spaces yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text('Start with a room scan or use manual setup.'),
                const SizedBox(height: AppSpacing.md),
                const ShelfIllustration(height: 142),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        for (final container in state.containers) ...[
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ContainerOverviewScreen(containerId: container.id),
              ),
            ),
            child: HardShadowCard(
              child: Row(
                children: [
                  const Icon(Icons.inventory_2_outlined),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      container.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        PrimaryActionButton(
          key: const Key('start-setup'),
          label: 'Scan new space',
          onPressed: onScan,
        ),
      ],
    );
  }
}

class _ScanPage extends StatelessWidget {
  const _ScanPage({
    required this.onScan,
    required this.onManual,
    required this.onExisting,
  });
  final VoidCallback onScan;
  final VoidCallback onManual;
  final VoidCallback onExisting;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg,
      104,
    ),
    children: [
      const ShelfPageHeader(
        eyebrow: 'Scan',
        title: 'Add inventory',
        subtitle: 'Start with a new space or update one you already use.',
      ),
      const SizedBox(height: AppSpacing.section),
      HardShadowCard(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: _PillLabel(label: 'DEFAULT'),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'New inventory space',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Scan the room first. Shelf will identify possible cabinets, shelves, racks, and drawers for you to confirm.',
            ),
            const SizedBox(height: AppSpacing.md),
            const ShelfIllustration(height: 132),
            const SizedBox(height: AppSpacing.md),
            PrimaryActionButton(
              key: const Key('scan-workspace'),
              label: 'Scan a workspace',
              onPressed: onScan,
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: onManual,
              child: const Text('SET UP MANUALLY →'),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.listItem),
      InkWell(
        onTap: onExisting,
        child: const HardShadowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add items to an existing section',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: AppSpacing.xs),
              Text('Choose a space, container, and section before scanning.'),
              SizedBox(height: AppSpacing.sm),
              Text(
                'CHOOSE LOCATION →',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: AppSpacing.listItem),
      HardShadowCard(
        color: Theme.of(context).colorScheme.tertiary,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Return borrowed items',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: AppSpacing.xs),
            Text('Scan an item, then confirm its section QR.'),
            SizedBox(height: AppSpacing.sm),
            Text(
              'START RETURN MODE →',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    ],
  );
}

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.label, this.color = Colors.white});
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

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F0EF),
      border: Border.all(width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    ),
  );
}
