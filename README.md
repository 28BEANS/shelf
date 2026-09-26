# Shelf

Shelf is a local-first inventory app for a shared equipment room. It saves a workspace, storage containers and sections, reviewed items, locations, loans, and movement history on the device.

## Current workflow

1. Enter the local Shelf workspace. The sign-in form is an entry gate; it does not authenticate against a server.
2. On a supported iPhone, start a room capture. RoomPlan is selected on a LiDAR-capable device; ARKit plane tracking and manual spatial storage marks are used otherwise. Review, rename, retype, remove, or manually add storage before confirming. In Chrome, use **Set up manually**.
3. Choose a container layout and select a section. On an iPhone, take a camera photo of item labels or barcodes. OCR/barcode output becomes review suggestions, which must be accepted or corrected. Manual item entry is also available.
4. Search by item, identifier, category, or location. Open an item to see its home and current section, move it, check it out with a borrower and due date, or confirm its return. Loan and move history stays attached to the item.

Room scans, confirmed storage geometry, items, and loan records are stored locally with Drift/SQLite. Production scan actions do not create sample detections.

## Run and verify

```bash
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
flutter build web
flutter build ios --simulator --no-codesign
```

The iOS build needs Xcode. A simulator can verify build, launch, and non-camera UI. Physical iPhones are required to validate ARKit tracking, camera-derived item suggestions, and LiDAR RoomPlan capture.

## Current scan limits

The iPhone 12 mini path collects ARKit room planes and can place a manual storage mark using a raycast. Optional Vision/Core ML storage detection is wired to load a bundled `StorageDetector.mlmodelc`, but no suitable licensed and validated model is bundled. Until one is supplied and tested, the capability reports `semanticStorage: false` and the app does not claim automatic storage recognition on non-LiDAR iPhones. RoomPlan and ARKit have compiled but have not yet been exercised on physical phones. Dimensions from ARKit marks or Core ML detections remain unknown rather than invented; detected planes are estimates.

The browser provides the complete manual inventory and loan route. Camera scanning is unavailable there. Data remains on the device; there is no cloud sync or shared authentication.

The [three-week plan](plans/three-week-development-plan.md), [mockups](docs/02-mockup.md), [design system](docs/03-design-system.md), and [weekly reports](docs/04-weekly-reports.md) describe the intended flow and the evidence still needed. The implementation plan for native capture was provided separately and is treated as a reference, not as proof of tested behavior.

## AI use and licence

AI-assisted tools were used for planning, implementation, testing, and documentation; see [AI-USAGE.md](AI-USAGE.md). The project is MIT licensed; see [LICENSE](LICENSE).
