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
      ref
          .read(setupProvider.notifier)
          .saveWorkspace('Campus Media Room', 'Shared equipment room');
    }
    if (manual) {
      ref
          .read(setupProvider.notifier)
          .saveContainer(
            ShelfContainer(
              id: 'manual-${DateTime.now().millisecondsSinceEpoch}',
              name: 'New Cabinet',
              type: 'Cabinet',
            ),
          );
    }
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SetupFlowScreen(manual: manual)));
    if (mounted) setState(() => _index = 0);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomePage(onScan: () => setState(() => _index = 1)),
      _ScanPage(
        onScan: () => _openSetup(),
        onManual: () => _openSetup(manual: true),
      ),
      const _SearchPage(),
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
        if (state.isComplete)
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
                const Text('Ready to use'),
                const SizedBox(height: AppSpacing.md),
                const ShelfIllustration(height: 148),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _Metric(value: '1', label: 'container'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _Metric(
                        value: '${state.sections.length}',
                        label: 'sections',
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Expanded(
                      child: _Metric(value: '0', label: 'items'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryActionButton(label: 'Open space', onPressed: () {}),
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
  const _ScanPage({required this.onScan, required this.onManual});
  final VoidCallback onScan;
  final VoidCallback onManual;

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
      const HardShadowCard(
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

class _SearchPage extends StatelessWidget {
  const _SearchPage();

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
        eyebrow: 'Inventory',
        title: 'Search',
        subtitle: 'Find an item and its physical home.',
      ),
      const SizedBox(height: AppSpacing.section),
      TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search items, categories, or locations',
        ),
      ),
      const SizedBox(height: AppSpacing.section),
      HardShadowCard(
        color: Theme.of(context).colorScheme.secondary,
        child: const Column(
          children: [
            Icon(Icons.search, size: 48),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Inventory search arrives in week 2.',
              textAlign: TextAlign.center,
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
