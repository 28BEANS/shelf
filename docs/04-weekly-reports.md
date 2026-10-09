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

The model search did not produce a bundle-ready detector: the [furniture model inspected](https://huggingface.co/ksh123k/furniture/raw/main/config.json) labels furniture, chairs, sofas, and tables but not cabinets or shelves, while an [Objects365-derived candidate](https://github.com/Peterande/D-FINE/issues/357) has unresolved checkpoint redistribution questions. Shelf therefore keeps automatic non-LiDAR storage recognition disabled until an appropriate model and its output labels are checked on device.

The native camera view now carries the mockup's scanning header, live status card, outlined actions, and an AR aiming reticle. The geometry contract retains all three surface dimensions; a horizontal AR plane's second extent is stored as depth rather than a wall height. A repository check also confirms repeated OCR suggestions do not create a duplicate item. Simulator and unsigned device builds passed after these changes; real capture had not yet been tested at that point.

**September 27 physical iPhone 12 mini test:**

- Device: iPhone 12 mini (`iPhone13,1`), iOS 26.6.2, wired and paired with Developer Mode enabled. A signed debug build installed and launched after the developer certificate was trusted. Camera access was granted. The live ARKit view showed actual camera frames and tracked a room plane; the saved plane's classification was `unknown`.
- The tester made two center-screen spatial marks in the live view. The room review reported one surface and two `manual_ar` storage observations. One marked cabinet was renamed, confirmed, and saved with ARKit geometry. A read-only copy of the phone's SQLite database contained one room scan, one confirmed container, and four sections. These marks demonstrate the manual AR path, not automatic semantic recognition.
- Real item-camera OCR created eight suggestions. Two were confirmed into Section 1; six remained pending. The displayed OCR names were imperfect, so a person must verify and correct suggestions before accepting them. The saved search view showed both items under the scanned cabinet and Section 1. No barcode was exercised.
- One item was checked out with a due date and then returned. The phone database showed one closed loan, zero active loans, both items available, and both current sections equal to their home sections. The tester relaunched the app and the scanned test workspace, its container, four sections, and two items were still visible. Flutter's debug app cannot be reopened directly from the iOS home screen; the tester relaunched it through Flutter tooling for this persistence check.
- A saved item was moved from Section 1 to Section 2. The container overview reflected its new current location, and the database retained its Section 1 home location with one movement record. Moving it back is a separate check.
- `flutter test` passed all 10 tests, `flutter analyze` found no issues, and the signed physical-device build succeeded. I later reviewed 12 iPhone screenshots and approved them for the public README; the phone database remains outside the repository.

**Still open after the physical test:** a licensed Core ML storage detector and its on-device accuracy/duplicate checks; LiDAR RoomPlan capture on a supported phone; barcode input, failure cases, and a measured scan-quality sample; the complete Chrome manual walkthrough. The single tracked plane and manual marks do not satisfy automatic non-LiDAR storage recognition acceptance.

**October 3 Shelf 2.0 authentication check:** Supabase Google OAuth redirected
successfully and the separate signed Shelf 2.0 build installed on the connected
iPhone 12 mini without replacing the original Shelf app. The tester completed
Google registration and six-digit passcode setup, reached the saved workspace,
used Log out, unlocked with the passcode, then closed and reopened Shelf 2.0.
The relaunch asked only for the passcode and the saved workspace remained.
Static analysis and all 15 automated tests passed. This verifies the account
and local unlock flow on that device; inventory remains on-device rather than
synced through Supabase.

## Week 3 (October 4-10, 2026)

Planned final-week focus: complete the core flow, verify the web fallback and
local data behavior, polish the documentation, and prepare the final demo.

### Early Week 3 progress, September 29–October 4

This work was developed incrementally before the October 4 final-week start.
The Week 3 changes were assembled into retrospective Git batches on October 4
with author and committer dates set across September 29–October 4. Those Git
dates are a reconstructed work log, not proof that each batch was committed
on its displayed date. Exact hours and a day-by-day time log were not recorded.

- The visual-scan direction was explored from September 29. The active build
  dropped the LiDAR workflow and now saves camera-backed room views with
  movable storage pins. Saved views can be removed. This is a labelled photo
  experience, not a textured 3D model or automatic shelf detector.
- On October 3, the separate Shelf 2.0 iPhone build gained Google registration
  through Supabase Auth, six-digit passcode setup and unlock, a lock-style
  **Log out** action, launch animation, and an interactive 3D shelf illustration.
  The owner verified Google sign-in, passcode relaunch, preserved workspace,
  and visible illustration drag interaction on an iPhone 12 mini. The original
  Shelf app stayed installed under its separate bundle identifier.
- The interactive graphic initially felt static on the phone. The later
  illustration change increased the visible response to dragging and removed
  its dark frame; the owner confirmed both on device.
- `flutter analyze` passed, 17 Flutter tests passed, and the release web build
  succeeded after the source changes. These are build checks, not proof that
  Google OAuth works in the public web demo. At that point, the Pages
  deployment was gated until its public OAuth configuration was provided.
- On October 4, the proposal, mockup notes, design-system notes, visual-scan
  plan, README, security checklist, and AI usage record were updated as dated
  additions. Older snapshots are retained for context.

**Open before a final submission:** exercise barcode and scanner failure
cases; audit all write-path validation; capture current Shelf 2.0 screenshots;
record the 3–5 minute demo and AI explanation; prepare the slides and square
image; verify public web OAuth before replacing the earlier browser demo.

### October 9 update

Account settings now offer deletion of the Supabase Shelf user and the data
saved on that device, with confirmation. `flutter analyze` and 18 Flutter
tests passed; the deletion tests use a fake auth gateway. The owner reports
testing browser sign-in and deletion in the current build. The
[GitHub Pages workflow](https://github.com/28BEANS/shelf/actions/runs/37929326030)
passed analysis, tests, and a release web build, then deployed commit
`3dd7b6c`. The public Shelf 2.0 sign-in screen loaded after deployment.
Current screenshots were added to the root README, and
[presentation deliverables](../PRESENTATION.md) link to the video, slides,
and square image. Barcode and scanner failure cases and a full write-path
validation audit remain open.
