enum ItemStatus { available, checkedOut, needsReview }

class WorkspaceDraft {
  const WorkspaceDraft({required this.name, this.description = ''});
  final String name;
  final String description;
}

class ShelfContainer {
  const ShelfContainer({
    required this.id,
    required this.name,
    required this.type,
    this.fromSampleScan = false,
  });
  final String id;
  final String name;
  final String type;
  final bool fromSampleScan;

  ShelfContainer copyWith({String? name, String? type}) => ShelfContainer(
    id: id,
    name: name ?? this.name,
    type: type ?? this.type,
    fromSampleScan: fromSampleScan,
  );
}

class ShelfSection {
  const ShelfSection({
    required this.id,
    required this.name,
    required this.order,
  });
  final String id;
  final String name;
  final int order;
  ShelfSection copyWith({String? name}) =>
      ShelfSection(id: id, name: name ?? this.name, order: order);
}

class ShelfItem {
  const ShelfItem({
    required this.id,
    required this.name,
    required this.location,
    this.status = ItemStatus.available,
  });
  final String id;
  final String name;
  final String location;
  final ItemStatus status;
}

class ScanCandidate {
  const ScanCandidate({
    required this.id,
    required this.name,
    required this.confidence,
    this.accepted = false,
  });
  final String id;
  final String name;
  final double confidence;
  final bool accepted;
}
