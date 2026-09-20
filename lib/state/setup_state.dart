import '../models/shelf_models.dart';

class SetupState {
  const SetupState({
    this.workspace,
    this.container,
    this.sections = const [],
    this.layoutLabel,
  });
  final WorkspaceDraft? workspace;
  final ShelfContainer? container;
  final List<ShelfSection> sections;
  final String? layoutLabel;
  bool get isComplete =>
      workspace != null && container != null && sections.isNotEmpty;

  SetupState copyWith({
    WorkspaceDraft? workspace,
    ShelfContainer? container,
    List<ShelfSection>? sections,
    String? layoutLabel,
  }) => SetupState(
    workspace: workspace ?? this.workspace,
    container: container ?? this.container,
    sections: sections ?? this.sections,
    layoutLabel: layoutLabel ?? this.layoutLabel,
  );
}
