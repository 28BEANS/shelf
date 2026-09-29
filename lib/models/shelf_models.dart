enum ItemStatus { available, checkedOut, needsReview }

class ShelfLoan {
  const ShelfLoan({
    required this.id,
    required this.itemId,
    required this.borrower,
    required this.dueAt,
    required this.checkedOutAt,
    this.returnedAt,
    required this.condition,
    required this.notes,
  });
  final String id, itemId, borrower, condition, notes;
  final DateTime dueAt, checkedOutAt;
  final DateTime? returnedAt;
}

class ShelfMove {
  const ShelfMove({
    required this.itemId,
    required this.fromSectionId,
    required this.toSectionId,
    required this.movedAt,
  });
  final String itemId, fromSectionId, toSectionId;
  final DateTime movedAt;
}

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
    this.geometryJson,
    this.roomScanId,
    this.markerPhotoPath,
    this.markerX,
    this.markerY,
  });
  final String id;
  final String name;
  final String type;
  final bool fromSampleScan;
  final String workspaceId;
  final String? layoutLabel;
  final String? geometryJson;
  final String? roomScanId;
  final String? markerPhotoPath;
  final double? markerX;
  final double? markerY;

  ShelfContainer copyWith({
    String? name,
    String? type,
    String? layoutLabel,
    String? markerPhotoPath,
    double? markerX,
    double? markerY,
    bool clearMarker = false,
  }) => ShelfContainer(
    id: id,
    name: name ?? this.name,
    type: type ?? this.type,
    fromSampleScan: fromSampleScan,
    workspaceId: workspaceId,
    layoutLabel: layoutLabel ?? this.layoutLabel,
    geometryJson: geometryJson,
    roomScanId: roomScanId,
    markerPhotoPath: clearMarker
        ? null
        : markerPhotoPath ?? this.markerPhotoPath,
    markerX: clearMarker ? null : markerX ?? this.markerX,
    markerY: clearMarker ? null : markerY ?? this.markerY,
  );
}

class ShelfVisualScan {
  const ShelfVisualScan({
    required this.id,
    required this.backend,
    required this.photoPaths,
    this.previewPath,
    this.modelPath,
    required this.visualStatus,
  });
  final String id;
  final String backend;
  final List<String> photoPaths;
  final String? previewPath;
  final String? modelPath;
  final String visualStatus;
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
    this.photoPath,
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
  final String? photoPath;
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
    this.photoPath,
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
  final String? photoPath;
}
