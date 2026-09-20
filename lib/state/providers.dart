import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shelf_models.dart';
import '../services/scan_service.dart';
import 'setup_state.dart';

final scanServiceProvider = Provider<ScanService>(
  (ref) => const DemoScanService(),
);
final setupProvider = NotifierProvider<SetupNotifier, SetupState>(
  SetupNotifier.new,
);

class SetupNotifier extends Notifier<SetupState> {
  @override
  SetupState build() => const SetupState();

  void saveWorkspace(String name, String description) {
    state = state.copyWith(
      workspace: WorkspaceDraft(
        name: name.trim(),
        description: description.trim(),
      ),
    );
  }

  void saveContainer(ShelfContainer container) =>
      state = state.copyWith(container: container);

  void chooseLayout(String label, int sectionCount) {
    final names = switch (label) {
      'Three sections' ||
      'Three shelves' => const ['Top Shelf', 'Middle Shelf', 'Bottom Shelf'],
      'Three drawers' => const ['Top Drawer', 'Middle Drawer', 'Bottom Drawer'],
      _ => List.generate(sectionCount, (index) => 'Section ${index + 1}'),
    };
    state = state.copyWith(
      layoutLabel: label,
      sections: List.generate(
        sectionCount,
        (index) => ShelfSection(
          id: 'section-${index + 1}',
          name: names[index],
          order: index,
        ),
      ),
    );
  }

  void renameSection(String id, String name) {
    state = state.copyWith(
      sections: [
        for (final section in state.sections)
          if (section.id == id)
            section.copyWith(name: name.trim())
          else
            section,
      ],
    );
  }
}
