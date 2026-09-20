import '../models/shelf_models.dart';

abstract interface class ScanService {
  bool get usesSampleData;
  Future<List<ShelfContainer>> scanContainers();
  Future<List<ScanCandidate>> scanItems(String sectionId);
}

class DemoScanService implements ScanService {
  const DemoScanService();
  @override
  bool get usesSampleData => true;
  @override
  Future<List<ShelfContainer>> scanContainers() async => const [
    ShelfContainer(
      id: 'sample-cabinet',
      name: 'Equipment Cabinet',
      type: 'Cabinet',
      fromSampleScan: true,
    ),
  ];
  @override
  Future<List<ScanCandidate>> scanItems(String sectionId) async => const [
    ScanCandidate(id: 'sample-1', name: 'Sony Camera Lens', confidence: .94),
    ScanCandidate(id: 'sample-2', name: 'NP-FZ100 Battery', confidence: .91),
    ScanCandidate(
      id: 'sample-3',
      name: 'Unknown black adapter',
      confidence: .54,
    ),
  ];
}
