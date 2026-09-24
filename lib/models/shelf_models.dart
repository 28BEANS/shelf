enum ItemStatus { available, checkedOut, needsReview }

class WorkspaceDraft {
  const WorkspaceDraft({
    required this.name,
    this.description = '',
    this.id = '',
  });
  final String id;
  final String name;
  final String description;
}

class ShelfContainer {
  const ShelfContainer({
    required this.id,
    required this.name,
    required this.type,
    this.fromSampleScan = false,
    this.workspaceId = '',
    this.layoutLabel,
  });
  final String id;
  final String name;
  final String type;
  final bool fromSampleScan;
  final String workspaceId;
  final String? layoutLabel;

  ShelfContainer copyWith({String? name, String? type, String? layoutLabel}) =>
      ShelfContainer(
        id: id,
        name: name ?? this.name,
        type: type ?? this.type,
        fromSampleScan: fromSampleScan,
        workspaceId: workspaceId,
        layoutLabel: layoutLabel ?? this.layoutLabel,
      );
}

class ShelfSection {
  const ShelfSection({
    required this.id,
    required this.name,
    required this.order,
    this.containerId = '',
  });
  final String id;
  final String name;
  final int order;
  final String containerId;
  ShelfSection copyWith({String? name}) => ShelfSection(
    id: id,
    name: name ?? this.name,
    order: order,
    containerId: containerId,
  );
}

class ShelfItem {
  const ShelfItem({
    required this.id,
    required this.name,
    required this.homeSectionId,
    required this.currentSectionId,
    this.category = 'Equipment',
    this.model = '',
    this.identifier = '',
    this.status = ItemStatus.available,
    required this.lastConfirmedAt,
  });
  final String id;
  final String name;
  final String homeSectionId;
  final String currentSectionId;
  final String category;
  final String model;
  final String identifier;
  final ItemStatus status;
  final DateTime lastConfirmedAt;
}

class ScanCandidate {
  const ScanCandidate({
    required this.id,
    required this.name,
    required this.confidence,
    this.accepted = false,
    this.category = 'Equipment',
    this.model = '',
    this.identifier = '',
    this.sectionId = '',
    this.state = 'pending',
    this.source = 'sample',
  });
  final String id;
  final String name;
  final double confidence;
  final bool accepted;
  final String category;
  final String model;
  final String identifier;
  final String sectionId;
  final String state;
  final String source;
}
