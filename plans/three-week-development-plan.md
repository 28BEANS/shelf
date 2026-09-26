# Shelf: three-week development plan

Prepared September 20, 2026; revised September 26 after the request for real iOS scanning and a complete MVP workflow in week 2. This is a forward-looking checklist. Completed work is recorded separately in the weekly reports.

September 20, September 27, and October 4 are treated as the starts of weeks 1, 2, and 3. The final week runs October 4–10, consistent with the existing weekly reports. October 4 is the start of final integration; October 10 is the proposed completion target, not a confirmed submission deadline.

## Outcome and starting point

Deliver a local, single-device inventory app for one shared equipment room. A user can scan a real room on a supported iPhone, review storage detections, configure containers and sections, capture and confirm items, find their physical home, and record a checkout and return. A manual route remains available when capture is unavailable or misses an object. Each week should end with a demonstrable increment.

As of September 26, the repository has the Shelf UI, a local Drift hierarchy, reviewed manual inventory, search, item details, and moves. Its room and item scans are still browser samples; checkout and return are not implemented. Week 2 now completes the real iOS scanning paths and the entire MVP workflow. Week 3 is for validation, fixes, and delivery.

## Weekly milestones

| Week | Dates | Main focus | Demonstrable result |
| --- | --- | --- | --- |
| 1 | September 20–26 | Design system and setup UI | Navigate from local entry to a workspace, container layout, and section using clearly labelled sample data. |
| 2 | September 27–October 3 | Real room scanning on LiDAR and non-LiDAR iPhones; complete MVP lifecycle | On physical devices, capture and review a room through each supported scanner, then complete and restart the full setup → item capture → search → checkout → return workflow with real saved data. |
| 3 | October 4–10 | Stabilization, pilot, evidence, and submission materials | Fix defects found in the complete workflow, document measured scan behavior and limitations, and deliver the demonstration. |

## Week 1: foundation and setup flow

**September 20–22: establish the shared UI**

- [x] Replace starter branding with Shelf and implement the light-only theme in `lib/theme.dart`.
- [x] Apply the reference palette, Plus Jakarta Sans and Space Mono typography, four-point spacing, 24 px screen rail, and outlined cards.
- [x] Build the mockup-aligned primary button, text field, three-tab navigation, hard-shadow cards, status labels, logo, locator rail, and scan-review patterns. Keep their data and callbacks separate from screen state.
- [x] Establish the Home, Scan, and Search navigation shell from the mockup. Use a local sign-in entry state; server-backed accounts remain outside the MVP.

**September 23–24: connect the setup screens**

- [x] Build workspace entry, manual container creation, container review, layout selection, and section selection using sample models.
- [x] Support renaming containers and sections, basic required-field validation, and back/cancel actions without losing in-session input.
- [x] Separate scan suggestions from confirmed inventory. Make simulated room and item results visibly identifiable as sample data.
- [x] Introduce Riverpod for shared workflow state and boundaries for storage and scan services.

**September 25–26: remove early risks and review**

- [x] Run the proposal's Drift persistence spike: save one item, restart, read it back, and update its status with a file-backed automated test; repeat save/read/update in Chrome. Simulator testing was removed from the workflow at the user's direction.
- [x] Confirm the iOS build environment and add the missing iOS project. LiDAR hardware remains unavailable for validation and is recorded as a blocker.
- [x] Check phone-width layouts, keyboard entry, validation, and empty states through widget tests and a Chrome walkthrough.
- [x] Replace the counter test with entry/navigation, validation, setup-flow, and persistence tests; run analysis, tests, and release builds.
- [x] Update the week 1 report with actual work and blockers. Exact hours and committed screenshots remain for the user to add if required.

**Week 1 acceptance:** the setup UI can reach a named container and section; shared controls follow the design system; sample data is labelled; the persistence spike and hardware checks have documented results. Full persistence is a week 2 deliverable.

## Week 2: real scanning and the complete MVP

**Baseline already built by September 26**

- [x] Persist the workspace, containers, sections, scan candidates, items, checkout-record schema, and movement records locally.
- [x] Provide manual container and item entry, candidate review, container overviews, search, item details, and basic moves.
- [ ] Replace the sample room and item scan service in the production flow. A sample UI is useful only as an explicitly separate development fixture; it is not scanning evidence.

**September 27: establish the scanner and device gates on the iPhone 12 mini**

- [ ] Use the confirmed iPhone 12 mini as the first physical test device. Record its iOS version, camera permission, AR world-tracking and plane-classification capabilities. Record the LiDAR iPhone when one becomes available; it is needed for RoomPlan validation. Do not use a simulator as scanning evidence.
- [ ] Define one Flutter-facing `ShelfRoom` contract for surfaces and storage units, including backend, dimensions, world transform, confidence, and stable Shelf IDs. Add capability, start, cancel, and typed-error operations through one native bridge. Select the backend automatically.
- [ ] Add camera permission and cancellation handling. Cancelled or failed captures must not create a room. Keep the browser path manual and remove sample detections from ordinary production scan actions.
- [ ] Obtain and bundle a usable, licensed Core ML storage-object detector for the non-LiDAR path, then verify its actual labels and outputs on device. The attachment's `StorageDetectorML` is an example name, not an asset currently in this repository. If a detector is unavailable, record semantic storage recognition as incomplete.

**September 28–29: capture, normalize, and review real rooms**

- [ ] Implement and test the non-LiDAR path first on the iPhone 12 mini: ARKit world tracking and plane collection. Use plane classification only when supported, run the bundled Vision/Core ML detector on selected frames, convert image coordinates correctly before raycasting, and label dimensions as estimates.
- [ ] Let a user mark a missed storage unit in the live AR view and resolve that mark against the observed room geometry. Save it as a manual annotation, never as a Vision detection. This keeps a real spatial scan useful if the detector misses an object, while leaving automatic semantic recognition unverified if the model is absent.
- [ ] Implement RoomPlan capture for supported LiDAR devices and map observed walls, doors, windows, openings, and storage objects into `ShelfRoom`. Show unknown classifications as unknown instead of inventing cabinet/shelf labels. Test this branch as soon as a LiDAR iPhone is available; a build alone is not validation.
- [ ] Stabilize repeated storage observations and suppress duplicates. Treat confidence and distance thresholds as values to tune on device, not guaranteed accuracy. Handle low light, limited tracking, empty results, model failure, and permission denial.
- [ ] Connect both backends to the same mockup-aligned room and storage review: confirm, rename, retype, remove, and manually add storage. Persist only confirmed scan results and keep logical container IDs independent of transient AR anchors and coordinates.
- [ ] Capture a real room on the iPhone 12 mini and retain device, backend, result, and error evidence. Repeat on a LiDAR iPhone as soon as one is available. A missing LiDAR phone or detector leaves the corresponding backend unverified; a manual route does not count as a passed scanner test.

**September 30–October 1: finish item capture and loans**

- [ ] Replace the sample item scan with real camera capture for a selected section. Use only actual on-device OCR/barcode or validated recognition results as suggestions; allow a person to name items the detector cannot identify. Accept, edit, remove, and add before saving. Repeating confirmation must not duplicate items.
- [ ] Complete checkout with borrower, due date, condition, and notes; update the item and checkout record together and reject a second active checkout. Complete return confirmation, restore availability, retain the home section, and close the loan in the same transaction.
- [ ] Show loan and movement history in item details or Activity. Preserve home/current location and timestamps through move, checkout, return, and restart. Search and empty states must work with the newly captured inventory.

**October 2–3: test the entire workflow on real data**

- [ ] On the iPhone 12 mini, run room capture → storage review → section setup → real item capture/manual correction → search → move → checkout → return → restart and verify saved results. Repeat room capture and review on a LiDAR iPhone as soon as one is available.
- [ ] Test cancellation, permission denial, no storage found, poor tracking, repeat scans, duplicate detections, multiple sections, duplicate checkout/return, and restart during an active loan. Check that a scan never silently overwrites confirmed containers or items.
- [ ] Run the manual browser journey with `-d chrome`, verify local persistence and release assets, and keep all fictional test records separate from the user's real workspace.
- [ ] Record measured scan quality and device limitations, capture a short walkthrough, update the week 2 report, and distinguish tested behavior from unverified claims.

**Week 2 acceptance:** on physical iPhones, each available scanner backend produces real, reviewable room data; the non-LiDAR path recognizes storage only if the bundled detector has actually been validated. The app completes setup → item capture → find → move → checkout → return and survives restart with correct locations and history. No production action creates fabricated detections. Both RoomPlan and non-LiDAR scanning must be marked unverified until each is tested on its required hardware; manual setup remains usable but does not satisfy scanner acceptance.

| Scan path | Physical test | Evidence required before marking complete |
| --- | --- | --- |
| RoomPlan | LiDAR iPhone | Actual capture of room surfaces and storage, review edits, confirmed persistence after restart, and recorded device/backend. |
| ARKit + Vision/Core ML | iPhone 12 mini | Actual planes and camera frames, validated storage labels, resolved positions with approximate dimensions, duplicate suppression, review, and persistence. |
| Section item capture | Supported iPhone | Actual camera input and only genuine OCR/barcode/model suggestions; manual correction linked to the chosen section; no duplicates after confirmation. |
| Failure and manual route | iPhone and Chrome | Denied permission, cancellation, empty/poor capture, and unsupported device do not save fabricated results; manual setup and the full loan cycle still work. |

## Week 3: stabilize and deliver the complete lifecycle

**October 4–6: resolve week 2 findings**

- [ ] Fix defects found in real-device scanning, review, persistence, checkout, return, and history. Re-test each affected path on the device where it failed.
- [ ] Tune non-LiDAR detection and tracking with recorded false positives, missed storage, and unstable measurements; show uncertainty rather than presenting estimated geometry as exact.
- [ ] If a required physical device or model was missing in week 2, record that acceptance was not met and secure the missing device or asset before making a scanner claim. Do not substitute sample data as a completion claim.

**October 7–8: verify and stabilize**

- [ ] Repeat the complete journey on the physical iOS targets and the manual Chrome path. Native-only services must not be invoked by the browser path.
- [ ] Pilot the app with a small equipment inventory and record completion, feedback, and whether search reveals the correct container/section in under 15 seconds, as proposed.
- [ ] Exercise a fictional dataset near the proposal's approximately 120 records, including about 80 items, to check search and list usability.
- [ ] Review narrow layouts, larger text, readable status labels, focus, validation, permission denial, unavailable scanning, and data retention after restart.
- [ ] Freeze features by October 8. Fix blocking defects before attempting additional capabilities.

**October 9–10: prepare the final handoff**

- [ ] Complete analysis, meaningful workflow/database tests, and a release web build; open the hosted version and verify the main journey.
- [ ] Replace README placeholders with Shelf's description, actual features, setup instructions, tested platforms, screenshots, live link, and known limitations.
- [ ] Reconcile proposal, mockup, design-system, security/privacy, and AI-use documentation with the implemented app.
- [ ] Record a 3–5 minute demonstration covering real room scanning where validated, storage review, section item capture, search, checkout, return, and persistence. State any backend that remained untested.
- [ ] Finish the week 3 report with actual outcomes, hours, remaining issues, and evidence; verify the repository and demo links.

**Final acceptance:** the complete MVP journey works from start to finish and survives restart; production scan results come from real sensors and reviewed detections; native scanning claims match physical-device evidence; documentation and demonstration represent the delivered app.

## Scope and fallback decisions

- **Required:** real room capture through RoomPlan on supported LiDAR iPhones and ARKit plus a validated on-device storage detector on supported non-LiDAR iPhones; shared review; real section item capture with supported Vision results and manual correction; setup, search, moves, checkout, return, history, and local persistence. Manual setup and entry are usable fallbacks, not substitutes for scanner testing. A browser demonstration follows the manual path and never reports a camera scan.
- **Hardware and asset gates:** The iPhone 12 mini is available for the first non-LiDAR tests. RoomPlan still needs a physical LiDAR iPhone, which will be tested as soon as one is available. Non-LiDAR semantic storage recognition needs an actual bundled Core ML detector with suitable labels. Check capability at runtime, report unsupported devices clearly, and do not set `semanticStorage` to true until the detector works. If either prerequisite is missing, record that part of scanner acceptance as unmet.
- **Stretch:** QR-assisted returns, batch returns, room highlighting, rescan/remap, advanced AR guidance, and drag-and-drop. Automatic recognition of every item or internal shelf is not assumed without a validated model. Scanned images and detections remain local unless the user explicitly chooses another destination.
- **Outside this delivery:** server-backed login, shared accounts, cloud synchronization, and multi-site inventory.
- **If behind on October 3:** stop stretch work, preserve a functional manual journey and honest scan status, and carry any unvalidated native path into the week 3 defect/evidence period. Do not replace the new scanner requirement with sample results or mark the full MVP complete.
- **If October 4 is the actual submission deadline:** this schedule needs compression; the existing reports treat it as the start of week 3. Do not assume an October 10 deadline has been assigned.

## How to work in increments

Choose one checklist task per work session. Finish it, verify the affected flow, and save a focused commit before starting another. At each week's end, capture a short walkthrough and update [weekly reports](../docs/04-weekly-reports.md) with evidence, not planned accomplishments. Carry unfinished core tasks forward before beginning optional work.

## References and interpretation

- [Proposal](../docs/01-proposal.md): revised MVP boundary, local persistence, hardware risks, and reviewable automation.
- [Design system](../docs/03-design-system.md): theme, typography, spacing, component contracts, and accessibility.
- [Mockup and screen documentation](../docs/02-mockup.md): setup, review, search, and lifecycle interactions.
- [Existing weekly reports](../docs/04-weekly-reports.md): the three weekly date ranges and UI-first starting direction.
- User-supplied *Shelf — iOS-Only Room Scanning Implementation Plan* (September 26): proposed unified room model, RoomPlan and ARKit/Vision paths, review, persistence, and device test matrix. Its snippets and placeholder model names are implementation ideas, not evidence that a model or scanner already exists.
- [Apple RoomPlan support](https://developer.apple.com/documentation/roomplan/roomcapturesession/issupported), [ARKit world tracking and plane classification](https://developer.apple.com/documentation/arkit/arworldtrackingconfiguration), and [Vision/Core ML requests](https://developer.apple.com/documentation/vision/vncoremlrequest): capability and model requirements to check during implementation.

The mockup remains the visual and interaction reference. The September 26 request revises the earlier proposal's scope: the real non-LiDAR detector and complete checkout/return lifecycle are now required for week 2, while QR/remapping remain optional. The earlier proposal's “custom model out of scope” and “manual fallback is enough for the MVP” assumptions no longer apply. Completed-work reports remain factual; this revised plan does not turn planned scanning into a completed result.
