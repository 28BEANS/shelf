# Weekly reports

## Week 1 (September 20-26, 2026)

**Done this week**

- Reviewed the revised proposal, mockup, and design-system source materials.
- Added the mockup screens, design-system visuals, and reference PDFs to
  `docs/assets/` so the project documentation can render from the repository.
- Documented the local-first MVP boundary, the logical inventory hierarchy, and
  the manual fallback for uncertain detection.
- Replaced the Flutter counter starter with the Shelf local sign-in and the
  three-tab Home, Scan, and Search shell shown in the mockups.
- Implemented the light Shelf theme and reusable pill actions, fields,
  hard-shadow cards, three-tab navigation, logo and locator headers, status
  labels, layout tiles, and scan-review patterns from the design system.
- Built the complete first setup increment to match the screen exports: Add
  Inventory, sample room scan, Detected Spaces, editable container review,
  two-column layout selection, section generation and renaming, and item review.
- Added Riverpod workflow state and separate scan-service and Drift storage
  boundaries.
- Completed the Drift spike. An automated file-backed test saves an item, closes
  and reopens the database, reads it, and updates its status. The same save,
  read, and update diagnostic passed in the running Chrome app.
- Added the compatible Drift web worker and WebAssembly assets, generated the
  iOS project scaffolding, and verified the release web build. Interactive
  development testing uses Chrome.
- Replaced the counter test with navigation, validation, narrow-phone setup-flow,
  and persistence tests. Static analysis and all four automated tests pass.

**In progress**

- Expanding the one-table Drift spike into the full workspace, room-scan,
  container, section, item, checkout, and scan-candidate schema in week 2.
- Connecting setup state to persistent records; week 1 setup state remains in
  memory by design.

**Blocked or stuck on**

- RoomPlan and LiDAR remain unvalidated. Nearby iPhones were discoverable but
  unavailable because they were locked or not in Developer Mode. Per the chosen
  test workflow, development testing uses Chrome; the manual setup path and
  labelled sample results remain available.
- Real item recognition and camera permissions are intentionally deferred until
  persistent manual inventory works.

**Decisions made, and why**

- Use a light-only, semantic Material theme so every screen can share the lime,
  lavender, mint, warm background, and near-black outline roles.
- Keep automation reviewable and provide manual alternatives because scan results
  may be incomplete or wrong.
- Build the UI foundation before persistence and native scanning so later screens
  can reuse stable widgets instead of inventing one-off styles.
- Use Chrome for interactive development tests. The iOS project remains buildable,
  but simulator testing is not part of the current workflow.

**Hours spent, roughly:** Not recorded yet.

**Next week I will:**

- Expand Drift to the full proposed schema and persist setup progress.
- Build persistent manual item entry and candidate review.
- Add container/section overviews, search, and item location details.

## Week 2 (September 27-October 3, 2026)

The earlier increment was implemented ahead of the planned September 27 start.
Its commits are dated September 24-26 at the project's request. The current
continuation was committed as work completed on September 27; the planned week
range above remains unchanged.

**Done in this increment**

- Expanded the Drift database to workspaces, room scans, containers, sections,
  items, checkout records, scan candidates, and movement records. Existing
  week-one databases migrate to the new schema without deleting the spike
  table.
- Saved workspace names, container details, layout choices, section names,
  candidates, and confirmed items locally. Stable section IDs survive layout
  edits. Layout reduction or container removal is blocked when it would
  orphan an item or its movement history.
- Added manual item entry and a section-specific review flow with accept,
  edit, remove, and confirm actions. Only accepted candidates become items;
  confirming the same batch again saves nothing.
- Added container and section overviews with counts and empty states, plus
  inventory search by name, category, model, identifier, container, and
  section. Item details show the saved home, current location, status, and
  last-confirmed time.
- Added a move flow that updates the current section, retains the original
  home section, and saves a movement record.
- Kept the browser scan path visibly labelled as sample data. Manual setup
  works without a camera or LiDAR.
- Static analysis, the release web build, the existing widget checks, and a
  focused database check for reopen, duplicate confirmation, section identity,
  and movement all passed. The app launched with `flutter run -d chrome`.

**In progress**

- A hands-on Chrome walkthrough of the complete create → restart → search
  journey remains to be recorded. Flutter's integration-test runner does not
  support Chrome web targets here, so the automated reopen check covers the
  saved hierarchy and item location instead.

**Blocked or stuck on**

- RoomPlan capture remains unvalidated because LiDAR hardware was not
  available. No native scanning result is claimed.
- No simulator was used for this earlier increment. The September 26-27 continuation below uses one after the testing instruction changed.

**Decisions made, and why**

- Review suggestions stay separate from confirmed inventory so sample or
  uncertain detections cannot silently become stored items.
- Moves change the current section while preserving the original home and
  movement history for the later activity view.

**Hours spent, roughly:** Not recorded yet.

**Next week I will:**

- Replace production sample scans with real ARKit/Vision capture and test it
  first on the available iPhone 12 mini. Implement RoomPlan and test it as
  soon as a LiDAR iPhone is available.
- Finish real section item capture, checkout, return, active-loan validation,
  and activity history so the full MVP journey works in week 2.
- Complete the Chrome manual journey walkthrough and record scanner evidence
  and any unmet hardware or detector prerequisites.

**Scope revision on September 26:** The earlier Week 2 increment above records
what was actually built; it does not establish scanning as complete. The
revised [three-week development plan](../plans/three-week-development-plan.md)
now makes real room scanning and the complete MVP lifecycle Week 2 acceptance
requirements. The manual path remains available, but sample scan results are
not accepted as evidence of a working iPhone scanner.

**September 26-27 continuation, before physical-device access:**

- Replaced production sample scan actions with a typed Flutter/native scanner bridge. The iOS code selects RoomPlan where supported and ARKit world tracking otherwise. ARKit collects planes and lets a user mark storage with a center-screen raycast. RoomPlan maps captured surfaces and recognized storage without inventing unknown labels. A Vision/Core ML detection pipeline is present but only activates when a `StorageDetector.mlmodelc` asset can actually be loaded; no suitable model is bundled, so non-LiDAR semantic storage recognition remains unavailable.
- Added real camera photo capture for a selected section. Vision OCR and barcode output become review suggestions; the person can accept, edit, remove, or add an item before it becomes inventory. Browser capture is disabled and manual setup remains available. A cancelled or failed scan does not save a room; only confirmed storage is persisted with its backend and geometry.
- Completed checkout, return, active-loan rejection, and dated loan/movement history. The repository test reopens an active loan, returns it, and verifies the saved home/current sections. Widget tests cover the checkout/return forms and a scan-review fixture that confirms only one of two proposed storage units.
- Analysis and automated checks pass, the web release build completes, and the iOS simulator build and launch succeed. The simulator screenshot was checked against the mockup style. The simulator cannot validate camera frames, room geometry, storage recognition, OCR accuracy, or LiDAR capture.

**Still open:** physical tests on the iPhone 12 mini and a LiDAR iPhone; a licensed, validated Core ML storage detector; measured scan quality and failure-mode evidence; and a full manual Chrome walkthrough. These are not marked as passed Week 2 scanner acceptance. Exact hours and device evidence remain to be recorded.

## Week 3 (October 4-10, 2026)

Planned final-week focus: complete the core flow, verify the web fallback and
local data behavior, polish the documentation, and prepare the final demo.
