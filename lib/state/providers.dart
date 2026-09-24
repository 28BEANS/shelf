import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_database.dart' hide ScanCandidate;
import '../data/inventory_repository.dart';
import '../models/shelf_models.dart';
import '../services/scan_service.dart';
import 'setup_state.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InventoryRepository(ref.watch(databaseProvider)),
);

final scanServiceProvider = Provider<ScanService>(
  (ref) => const DemoScanService(),
);

final setupProvider = NotifierProvider<SetupNotifier, SetupState>(
  SetupNotifier.new,
);

class SetupNotifier extends Notifier<SetupState> {
  InventoryRepository get repository => ref.read(inventoryRepositoryProvider);

  @override
  SetupState build() {
    Future.microtask(refresh);
    return const SetupState();
  }

  Future<void> refresh({String? containerId}) async {
    try {
      state = await repository.load(
        selectedContainerId: containerId ?? state.container?.id,
      );
    } catch (error) {
      state = state.copyWith(loading: false, error: error.toString());
    }
  }

  Future<void> saveWorkspace(String name, String description) async {
    await repository.saveWorkspace(name, description);
    await refresh();
  }

  Future<void> saveContainer(ShelfContainer container) async {
    var workspace = state.workspace;
    if (workspace == null) {
      await saveWorkspace('Campus Media Room', 'Shared equipment room');
      workspace = state.workspace;
    }
    await repository.saveContainer(container, workspace!.id);
    await refresh(containerId: container.id);
  }

  Future<void> recordSampleRoomScan() async {
    final workspace = state.workspace;
    final container = state.container;
    if (workspace != null && container != null) {
      await repository.recordSampleRoomScan(workspace.id, container.id);
    }
  }

  Future<void> chooseLayout(String label, int sectionCount) async {
    final container = state.container;
    if (container == null) return;
    final names = switch (label) {
      'Three sections' ||
      'Three shelves' => const ['Top Shelf', 'Middle Shelf', 'Bottom Shelf'],
      'Three drawers' => const ['Top Drawer', 'Middle Drawer', 'Bottom Drawer'],
      _ => List.generate(sectionCount, (index) => 'Section ${index + 1}'),
    };
    await repository.saveLayout(container, label, names);
    await refresh(containerId: container.id);
  }

  Future<void> renameSection(String id, String name) async {
    await repository.renameSection(id, name);
    await refresh();
  }

  Future<void> selectContainer(String id) => refresh(containerId: id);

  Future<void> addSampleCandidates(
    String sectionId,
    List<ScanCandidate> suggestions,
  ) async {
    await repository.addSampleCandidates(sectionId, suggestions);
    await refresh();
  }

  Future<void> addCandidate({
    required String sectionId,
    required String name,
    String category = 'Equipment',
    String model = '',
    String identifier = '',
  }) async {
    await repository.addCandidate(
      sectionId: sectionId,
      name: name,
      category: category,
      model: model,
      identifier: identifier,
    );
    await refresh();
  }

  Future<void> updateCandidate(
    String id, {
    String? name,
    String? category,
    String? model,
    String? identifier,
    String? state,
  }) async {
    await repository.updateCandidate(
      id,
      name: name,
      category: category,
      model: model,
      identifier: identifier,
      state: state,
    );
    await refresh();
  }

  Future<int> confirmCandidates(String sectionId) async {
    final workspace = state.workspace;
    if (workspace == null) return 0;
    final count = await repository.confirmCandidates(sectionId, workspace.id);
    await refresh();
    return count;
  }

  Future<void> moveItem(String itemId, String sectionId) async {
    await repository.moveItem(itemId, sectionId);
    await refresh();
  }
}
