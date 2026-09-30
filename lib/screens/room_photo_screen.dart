import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../state/providers.dart';
import '../theme.dart';
import '../widgets/hard_shadow_card.dart';
import '../widgets/shelf_brand.dart';
import '../widgets/shelf_room_photo.dart';
import 'inventory_screens.dart';

class RoomPhotoScreen extends ConsumerStatefulWidget {
  const RoomPhotoScreen({super.key});

  @override
  ConsumerState<RoomPhotoScreen> createState() => _RoomPhotoScreenState();
}

class _RoomPhotoScreenState extends ConsumerState<RoomPhotoScreen> {
  int selectedView = 0;
  bool editing = false;
  String? movingContainerId;

  Future<ShelfContainer?> _askMarker(
    ShelfContainer draft, {
    bool existing = false,
  }) async {
    final name = TextEditingController(text: draft.name);
    var type = draft.type;
    final action = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            existing ? 'Edit storage marker' : 'Name this storage spot',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: AppSpacing.sm),
              DropdownButtonFormField<String>(
                initialValue: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: [
                  for (final value in const [
                    'Cabinet',
                    'Shelf',
                    'Drawer',
                    'Rack',
                    'Storage',
                    'Other',
                    'Unknown',
                  ])
                    DropdownMenuItem(value: value, child: Text(value)),
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
            if (existing)
              TextButton(
                onPressed: () => Navigator.pop(context, 'remove'),
                child: const Text('REMOVE PIN'),
              ),
            if (existing)
              TextButton(
                onPressed: () => Navigator.pop(context, 'move'),
                child: const Text('MOVE PIN'),
              ),
            FilledButton(
              onPressed: () {
                if (name.text.trim().isNotEmpty) Navigator.pop(context, 'save');
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
    final updated = draft.copyWith(name: name.text.trim(), type: type);
    name.dispose();
    if (action == 'remove') return updated.copyWith(clearMarker: true);
    if (action == 'move') {
      setState(() {
        editing = true;
        movingContainerId = draft.id;
      });
      return updated;
    }
    return action == 'save' ? updated : null;
  }

  Future<void> _saveMarker(ShelfContainer container) async {
    try {
      await ref.read(setupProvider.notifier).saveContainer(container);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save marker: $error')),
        );
      }
    }
  }

  Future<void> _placePin(String photoPath, double x, double y) async {
    final state = ref.read(setupProvider);
    final scan = state.visualScan;
    if (scan == null) return;
    if (movingContainerId != null) {
      final existing = state.containerById(movingContainerId!);
      if (existing != null) {
        await _saveMarker(
          existing.copyWith(markerPhotoPath: photoPath, markerX: x, markerY: y),
        );
      }
      if (mounted) setState(() => movingContainerId = null);
      return;
    }
    final draft = ShelfContainer(
      id: 'container-${DateTime.now().microsecondsSinceEpoch}',
      name: 'Storage spot',
      type: 'Storage',
      roomScanId: scan.id,
      markerPhotoPath: photoPath,
      markerX: x,
      markerY: y,
    );
    final named = await _askMarker(draft);
    if (named != null) await _saveMarker(named);
  }

  Future<void> _removeView(String photoPath) async {
    final state = ref.read(setupProvider);
    final scan = state.visualScan;
    if (scan == null) return;
    final pinned = state.containers
        .where((container) => container.markerPhotoPath == photoPath)
        .toList();
    if (pinned.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Move its storage pins before removing this view.'),
        ),
      );
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove this room view?'),
        content: const Text(
          'The photo will be deleted from this device. Your other room views and saved items will stay.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('KEEP VIEW'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('REMOVE VIEW'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await ref
          .read(setupProvider.notifier)
          .removeRoomPhoto(scan.id, photoPath);
      if (!mounted) return;
      final remaining = ref.read(setupProvider).visualScan?.photoPaths ?? [];
      if (remaining.isEmpty) {
        Navigator.pop(context);
      } else {
        setState(
          () => selectedView = selectedView.clamp(0, remaining.length - 1),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Room view removed.')));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not remove view: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupProvider);
    final scan = state.visualScan;
    if (scan == null || scan.photoPaths.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No saved room view yet.')),
      );
    }
    final path =
        scan.photoPaths[selectedView.clamp(0, scan.photoPaths.length - 1)];
    return Scaffold(
      body: ShelfMobileRail(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const ShelfBackButton(label: 'Back to spaces'),
              const SizedBox(height: AppSpacing.md),
              ShelfPageHeader(
                eyebrow: 'Saved photo view',
                title: state.workspace?.name ?? 'Workspace',
                subtitle: editing
                    ? 'Tap the photo to place a pin. Tap a pin to edit it.'
                    : 'Tap a marker to open its storage sections.',
              ),
              const SizedBox(height: AppSpacing.md),
              ShelfRoomPhoto(
                photoPath: path,
                markers: state.containers,
                height: 470,
                onPhotoTap: editing ? (x, y) => _placePin(path, x, y) : null,
                onMarkerTap: (container) async {
                  if (editing) {
                    final updated = await _askMarker(container, existing: true);
                    if (updated != null) await _saveMarker(updated);
                  } else {
                    if (!context.mounted) return;
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
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () => _removeView(path),
                icon: const Icon(Icons.delete_outline),
                label: const Text('REMOVE THIS VIEW'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton.icon(
                onPressed: () => setState(() {
                  editing = !editing;
                  movingContainerId = null;
                }),
                icon: Icon(
                  editing ? Icons.check : Icons.add_location_alt_outlined,
                ),
                label: Text(editing ? 'DONE EDITING' : 'ADD OR EDIT PINS'),
              ),
              if (movingContainerId != null)
                const Text(
                  'Tap the new position in a room view to move this pin.',
                ),
              if (scan.photoPaths.length > 1)
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    for (var index = 0; index < scan.photoPaths.length; index++)
                      ChoiceChip(
                        label: Text('View ${index + 1}'),
                        selected: selectedView == index,
                        onSelected: (_) => setState(() => selectedView = index),
                      ),
                  ],
                ),
              const SizedBox(height: AppSpacing.md),
              const HardShadowCard(
                child: Text(
                  'This is a saved room photo view. A textured 3D model is not available for this scan.',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'STORAGE SPOTS',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final container in state.containers) ...[
                TextButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ContainerOverviewScreen(containerId: container.id),
                    ),
                  ),
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: Text(container.name),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
