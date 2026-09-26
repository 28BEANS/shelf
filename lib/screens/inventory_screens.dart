import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../state/providers.dart';
import '../state/setup_state.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/shelf_brand.dart';
import '../widgets/shelf_bottom_navigation.dart';
import 'setup_flow_screen.dart';

class ContainerOverviewScreen extends ConsumerWidget {
  const ContainerOverviewScreen({super.key, required this.containerId});
  final String containerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupProvider);
    final container = state.containerById(containerId);
    if (container == null) {
      return const Scaffold(body: Center(child: Text('Container unavailable')));
    }
    final sections =
        state.allSections
            .where((section) => section.containerId == containerId)
            .toList()
          ..sort((a, b) => a.order.compareTo(b.order));
    final count = sections.fold<int>(
      0,
      (total, section) => total + state.countForSection(section.id),
    );
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              ShelfPageHeader(
                eyebrow: state.workspace?.name ?? 'Workspace',
                title: container.name,
                subtitle: '$count items across ${sections.length} sections.',
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LAYOUT OVERVIEW',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (var i = 0; i < sections.length; i++) ...[
                      InkWell(
                        onTap: () =>
                            _openSection(context, sections[i], container),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: i == 0
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  sections[i].name.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              _StatusTag(
                                label:
                                    state.countForSection(sections[i].id) == 0
                                    ? 'EMPTY'
                                    : '${state.countForSection(sections[i].id)} ITEMS',
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (i < sections.length - 1)
                        const SizedBox(height: AppSpacing.sm),
                    ],
                    if (sections.isEmpty)
                      const Text('Choose a layout to add sections.'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final section in sections) ...[
                InkWell(
                  onTap: () => _openSection(context, section, container),
                  child: HardShadowCard(
                    dashed: state.countForSection(section.id) == 0,
                    color: state.countForSection(section.id) == 1
                        ? Theme.of(context).colorScheme.tertiary
                        : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                section.name.toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            _StatusTag(
                              label: state.countForSection(section.id) == 0
                                  ? 'EMPTY'
                                  : 'SAVED',
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        if (state.countForSection(section.id) == 0)
                          const Text('No items scanned yet')
                        else
                          for (final item in state.items.where(
                            (item) => item.currentSectionId == section.id,
                          ))
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ItemDetailScreen(itemId: item.id),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.inventory_2_outlined,
                                      size: 22,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(child: Text(item.name)),
                                    const Icon(Icons.arrow_forward, size: 18),
                                  ],
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.sm),
              PrimaryActionButton(
                label: 'Add more items',
                onPressed: sections.isEmpty
                    ? null
                    : () => _openSection(context, sections.first, container),
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(setupProvider.notifier)
                      .selectContainer(containerId);
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SetupFlowScreen(editLayout: true),
                      ),
                    );
                  }
                },
                child: const Text('EDIT LAYOUT →'),
              ),
              TextButton(
                onPressed: () async {
                  final remove = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove container?'),
                      content: Text(
                        'Remove ${container.name} and its empty sections?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('CANCEL'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('REMOVE'),
                        ),
                      ],
                    ),
                  );
                  if (remove != true) return;
                  try {
                    await ref
                        .read(setupProvider.notifier)
                        .removeContainer(containerId);
                    if (context.mounted) Navigator.pop(context);
                  } on StateError catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(error.message)));
                    }
                  }
                },
                child: const Text('REMOVE CONTAINER'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ShelfBottomNavigation(
        currentIndex: 0,
        onDestinationSelected: (_) => Navigator.pop(context),
      ),
    );
  }

  void _openSection(
    BuildContext context,
    ShelfSection section,
    ShelfContainer container,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CandidatePreviewScreen(section: section),
      ),
    );
  }
}

class InventorySearchPage extends ConsumerStatefulWidget {
  const InventorySearchPage({super.key, this.initialFilter = 'ALL'});
  final String initialFilter;
  @override
  ConsumerState<InventorySearchPage> createState() =>
      _InventorySearchPageState();
}

class _InventorySearchPageState extends ConsumerState<InventorySearchPage> {
  final _search = TextEditingController();
  late String _filter = widget.initialFilter;
  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupProvider);
    final query = _search.text.trim().toLowerCase();
    final items = state.items.where((item) {
      if (_filter == 'STORED' && item.status != ItemStatus.available) {
        return false;
      }
      if (_filter == 'CHECKED OUT' && item.status != ItemStatus.checkedOut) {
        return false;
      }
      final section = state.sectionById(item.currentSectionId);
      final container = section == null
          ? null
          : state.containerById(section.containerId);
      final homeSection = state.sectionById(item.homeSectionId);
      final homeContainer = homeSection == null
          ? null
          : state.containerById(homeSection.containerId);
      return query.isEmpty ||
          [
            item.name,
            item.category,
            item.model,
            item.identifier,
            section?.name ?? '',
            container?.name ?? '',
            homeSection?.name ?? '',
            homeContainer?.name ?? '',
          ].any((field) => field.toLowerCase().contains(query));
    }).toList();
    return ListView(
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
          subtitle: 'Find an item by name, model, or location.',
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _search,
          decoration: const InputDecoration(
            labelText: 'Search inventory',
            hintText: 'Name, category, identifier, or location',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 6,
          children: [
            for (final label in const ['ALL', 'STORED', 'CHECKED OUT'])
              ChoiceChip(
                label: Text(label),
                selected: _filter == label,
                onSelected: (_) => setState(() => _filter = label),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${items.length} ${items.length == 1 ? 'RESULT' : 'RESULTS'}',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        if (items.isEmpty)
          HardShadowCard(
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              children: [
                const Icon(Icons.search_off, size: 48),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  state.items.isEmpty
                      ? 'No items saved yet. Add inventory to a section.'
                      : 'No matches. Try a name, category, identifier, or location.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        for (final item in items) ...[
          HardShadowCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    _StatusTag(
                      label: item.status == ItemStatus.available
                          ? 'STORED'
                          : 'CHECKED OUT',
                      color: item.status == ItemStatus.available
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
                Text(
                  [
                    item.identifier,
                    item.category,
                  ].where((s) => s.isNotEmpty).join(' • '),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                _ItemVisual(item: item, height: 110),
                const SizedBox(height: AppSpacing.sm),
                _LocationCard(state: state, item: item),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ItemDetailScreen(itemId: item.id),
              ),
            ),
            child: const HardShadowCard(
              child: Row(
                children: [
                  Text(
                    'VIEW ITEM DETAILS',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({super.key, required this.itemId});
  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupProvider);
    final matches = state.items.where((item) => item.id == itemId);
    if (matches.isEmpty) {
      return const Scaffold(body: Center(child: Text('Item unavailable')));
    }
    final item = matches.first;
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              ShelfPageHeader(
                eyebrow: item.status == ItemStatus.available
                    ? 'Stored item'
                    : 'Checked out item',
                title: item.name,
                subtitle: item.model.isEmpty ? item.category : item.model,
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        _StatusTag(
                          label: item.status == ItemStatus.available
                              ? 'STORED'
                              : 'CHECKED OUT',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _ItemVisual(item: item, height: 170),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _LocationCard(state: state, item: item, showCurrent: true),
              const SizedBox(height: AppSpacing.md),
              PrimaryActionButton(
                label: item.status == ItemStatus.checkedOut
                    ? 'Return item'
                    : 'Check out item',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoanActionScreen(
                      itemId: item.id,
                      returning: item.status == ItemStatus.checkedOut,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                child: Column(
                  children: [
                    _DetailRow(label: 'CATEGORY', value: item.category),
                    _DetailRow(
                      label: 'MODEL',
                      value: item.model.isEmpty ? '—' : item.model,
                    ),
                    _DetailRow(
                      label: 'IDENTIFIER',
                      value: item.identifier.isEmpty ? '—' : item.identifier,
                    ),
                    _DetailRow(
                      label: 'STATUS',
                      value: item.status == ItemStatus.available
                          ? 'Stored'
                          : 'Checked out',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MoveItemScreen(itemId: item.id),
                  ),
                ),
                child: const HardShadowCard(
                  child: Row(
                    children: [
                      Text(
                        'MOVE TO ANOTHER SECTION',
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
              HardShadowCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVITY',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final loan in state.loans.where(
                      (loan) => loan.itemId == item.id,
                    ))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Text(
                          'Checked out ${MaterialLocalizations.of(context).formatMediumDate(loan.checkedOutAt)} to ${loan.borrower}\nDue ${MaterialLocalizations.of(context).formatMediumDate(loan.dueAt)} • ${loan.condition}${loan.notes.isEmpty ? '' : ' • ${loan.notes}'}\n${loan.returnedAt == null ? 'Active loan' : 'Returned ${MaterialLocalizations.of(context).formatMediumDate(loan.returnedAt!)}'}',
                        ),
                      ),
                    for (final move in state.moves.where(
                      (move) => move.itemId == item.id,
                    ))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Text(
                          'Moved ${MaterialLocalizations.of(context).formatMediumDate(move.movedAt)}\n${state.locationFor(move.fromSectionId)} → ${state.locationFor(move.toSectionId)}',
                        ),
                      ),
                    if (state.loans.every((loan) => loan.itemId != item.id) &&
                        state.moves.every((move) => move.itemId != item.id))
                      const Text('No activity yet.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ShelfBottomNavigation(
        currentIndex: 2,
        onDestinationSelected: (_) => Navigator.pop(context),
      ),
    );
  }
}

class LoanActionScreen extends ConsumerStatefulWidget {
  const LoanActionScreen({
    super.key,
    required this.itemId,
    required this.returning,
  });
  final String itemId;
  final bool returning;
  @override
  ConsumerState<LoanActionScreen> createState() => _LoanActionScreenState();
}

class _LoanActionScreenState extends ConsumerState<LoanActionScreen> {
  final _borrower = TextEditingController();
  final _notes = TextEditingController();
  final _form = GlobalKey<FormState>();
  DateTime? _due;
  String _condition = 'Good';
  bool _busy = false;

  @override
  void dispose() {
    _borrower.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    if (!widget.returning &&
        (!_form.currentState!.validate() || _due == null)) {
      if (_due == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Choose an expected return date.')),
        );
      }
      return;
    }
    setState(() => _busy = true);
    try {
      if (widget.returning) {
        await ref.read(setupProvider.notifier).returnItem(widget.itemId);
      } else {
        await ref
            .read(setupProvider.notifier)
            .checkoutItem(
              widget.itemId,
              _borrower.text,
              _due!,
              _condition,
              _notes.text,
            );
      }
      if (mounted) Navigator.pop(context);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupProvider);
    final matches = state.items.where((item) => item.id == widget.itemId);
    if (matches.isEmpty) {
      return const Scaffold(body: Center(child: Text('Item unavailable')));
    }
    final item = matches.first;
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: Form(
            key: _form,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                ShelfPageHeader(
                  eyebrow: widget.returning
                      ? 'Return mode'
                      : item.category.toUpperCase(),
                  title: widget.returning ? 'Return an item' : 'Check out item',
                  subtitle: widget.returning
                      ? 'Confirm this item has been returned.'
                      : 'Record who is borrowing it.',
                ),
                const SizedBox(height: AppSpacing.md),
                HardShadowCard(
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 40),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              item.identifier.isEmpty
                                  ? state.locationFor(item.homeSectionId)
                                  : '${item.identifier} • ${state.locationFor(item.homeSectionId)}',
                            ),
                          ],
                        ),
                      ),
                      _StatusTag(
                        label: widget.returning ? 'ON LOAN' : 'STORED',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (!widget.returning) ...[
                  TextFormField(
                    controller: _borrower,
                    decoration: const InputDecoration(labelText: 'Borrower *'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter a borrower'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton(
                    onPressed: () async {
                      final chosen = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(
                          const Duration(days: 1),
                        ),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 3650),
                        ),
                      );
                      if (chosen != null) {
                        setState(
                          () => _due = DateTime(
                            chosen.year,
                            chosen.month,
                            chosen.day,
                            23,
                            59,
                          ),
                        );
                      }
                    },
                    child: Text(
                      _due == null
                          ? 'EXPECTED RETURN *'
                          : 'EXPECTED RETURN: ${MaterialLocalizations.of(context).formatMediumDate(_due!)}',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  HardShadowCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONDITION',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Wrap(
                          spacing: 4,
                          children: [
                            for (final value in const [
                              'Good',
                              'Fair',
                              'Needs repair',
                            ])
                              ChoiceChip(
                                label: Text(value.toUpperCase()),
                                selected: _condition == value,
                                onSelected: (_) =>
                                    setState(() => _condition = value),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextFormField(
                    controller: _notes,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                    ),
                    maxLines: 2,
                  ),
                ] else ...[
                  HardShadowCard(
                    color: Theme.of(context).colorScheme.secondary,
                    child: const Text(
                      '01  ITEM SELECTED\n02  VERIFY HOME SECTION\n03  CONFIRM RETURN',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                HardShadowCard(
                  color: Theme.of(context).colorScheme.tertiary,
                  child: Text(
                    'HOME LOCATION STAYS SAVED\n${state.locationFor(item.homeSectionId)}',
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryActionButton(
                  label: _busy
                      ? 'Saving…'
                      : widget.returning
                      ? 'Confirm return'
                      : 'Confirm checkout',
                  onPressed: _busy ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ShelfBottomNavigation(
        currentIndex: widget.returning ? 1 : 2,
        onDestinationSelected: (_) => Navigator.pop(context),
      ),
    );
  }
}

class MoveItemScreen extends ConsumerStatefulWidget {
  const MoveItemScreen({super.key, required this.itemId});
  final String itemId;
  @override
  ConsumerState<MoveItemScreen> createState() => _MoveItemScreenState();
}

class _MoveItemScreenState extends ConsumerState<MoveItemScreen> {
  String? _containerId;
  String? _sectionId;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupProvider);
    final matches = state.items.where((item) => item.id == widget.itemId);
    if (matches.isEmpty) {
      return const Scaffold(body: Center(child: Text('Item unavailable')));
    }
    final item = matches.first;
    final currentSection = state.sectionById(item.currentSectionId);
    final containerId = _containerId ?? currentSection?.containerId;
    final sections =
        state.allSections
            .where((section) => section.containerId == containerId)
            .toList()
          ..sort((a, b) => a.order.compareTo(b.order));
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              ShelfPageHeader(
                eyebrow: item.name,
                title: 'Move item',
                subtitle: 'Choose its current section.',
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.tertiary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT LOCATION',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      state.workspace?.name ?? 'Workspace',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(state.locationFor(item.currentSectionId)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WORKSPACE',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(state.workspace?.name ?? 'Workspace'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              HardShadowCard(
                child: DropdownButtonFormField<String>(
                  initialValue: containerId,
                  decoration: const InputDecoration(labelText: 'CONTAINER'),
                  items: [
                    for (final container in state.containers)
                      DropdownMenuItem(
                        value: container.id,
                        child: Text(container.name),
                      ),
                  ],
                  onChanged: (value) => setState(() {
                    _containerId = value;
                    _sectionId = null;
                  }),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              HardShadowCard(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHOOSE SECTION',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    for (final section in sections) ...[
                      InkWell(
                        onTap: () => setState(() => _sectionId = section.id),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _sectionId == section.id
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(section.name.toUpperCase())),
                              Text(
                                state.countForSection(section.id) == 0
                                    ? 'Empty'
                                    : '${state.countForSection(section.id)} items',
                              ),
                              if (_sectionId == section.id)
                                const Icon(Icons.check),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const HardShadowCard(
                child: Text(
                  'The original home location stays in the item record. This move updates the current location.',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryActionButton(
                label: _saving ? 'Moving…' : 'Move item',
                onPressed:
                    _saving ||
                        _sectionId == null ||
                        _sectionId == item.currentSectionId
                    ? null
                    : () async {
                        setState(() => _saving = true);
                        await ref
                            .read(setupProvider.notifier)
                            .moveItem(item.id, _sectionId!);
                        if (context.mounted) Navigator.pop(context);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.state,
    required this.item,
    this.showCurrent = false,
  });
  final SetupState state;
  final ShelfItem item;
  final bool showCurrent;
  @override
  Widget build(BuildContext context) => HardShadowCard(
    color: Theme.of(context).colorScheme.tertiary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('WHERE IT BELONGS', style: Theme.of(context).textTheme.labelLarge),
        Text(
          state.workspace?.name ?? 'Workspace',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(state.locationFor(item.homeSectionId)),
        if (showCurrent && item.currentSectionId != item.homeSectionId) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            'CURRENT LOCATION',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(state.locationFor(item.currentSectionId)),
        ],
        Text(
          'Last confirmed ${MaterialLocalizations.of(context).formatMediumDate(item.lastConfirmedAt)}, ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(item.lastConfirmedAt))}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    ),
  );
}

class _ItemVisual extends StatelessWidget {
  const _ItemVisual({required this.item, required this.height});
  final ShelfItem item;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isCamera =
        '${item.name} ${item.category}'.toLowerCase().contains('camera') ||
        item.name.toLowerCase().contains('lens');
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(7),
      ),
      child: isCamera
          ? Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(width: 3),
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Icon(Icons.inventory_2_outlined, size: 64),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: Theme.of(context).textTheme.labelSmall),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.label, this.color = Colors.white});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 2),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(label, style: Theme.of(context).textTheme.labelSmall),
  );
}
