import '../models/shelf_models.dart';

class SetupState {
  const SetupState({
    this.loading = true,
    this.error,
    this.workspace,
    this.container,
    this.containers = const [],
    this.sections = const [],
    this.allSections = const [],
    this.items = const [],
    this.candidates = const [],
    this.layoutLabel,
  });

  final bool loading;
  final String? error;
  final WorkspaceDraft? workspace;
  final ShelfContainer? container;
  final List<ShelfContainer> containers;
  final List<ShelfSection> sections;
  final List<ShelfSection> allSections;
  final List<ShelfItem> items;
  final List<ScanCandidate> candidates;
  final String? layoutLabel;

  bool get isComplete =>
      workspace != null && container != null && sections.isNotEmpty;

  int countForSection(String sectionId) =>
      items.where((item) => item.currentSectionId == sectionId).length;

  ShelfSection? sectionById(String id) {
    for (final section in allSections) {
      if (section.id == id) return section;
    }
    return null;
  }

  ShelfContainer? containerById(String id) {
    for (final container in containers) {
      if (container.id == id) return container;
    }
    return null;
  }

  String locationFor(String sectionId) {
    final section = sectionById(sectionId);
    if (section == null) return 'Unknown section';
    final container = containerById(section.containerId);
    return '${container?.name ?? 'Unknown container'} → ${section.name}';
  }

  SetupState copyWith({
    bool? loading,
    String? error,
    WorkspaceDraft? workspace,
    ShelfContainer? container,
    List<ShelfContainer>? containers,
    List<ShelfSection>? sections,
    List<ShelfSection>? allSections,
    List<ShelfItem>? items,
    List<ScanCandidate>? candidates,
    String? layoutLabel,
  }) => SetupState(
    loading: loading ?? this.loading,
    error: error,
    workspace: workspace ?? this.workspace,
    container: container ?? this.container,
    containers: containers ?? this.containers,
    sections: sections ?? this.sections,
    allSections: allSections ?? this.allSections,
    items: items ?? this.items,
    candidates: candidates ?? this.candidates,
    layoutLabel: layoutLabel ?? this.layoutLabel,
  );
}
