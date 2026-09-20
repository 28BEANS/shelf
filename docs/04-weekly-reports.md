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

Planned focus: continue from the visual foundation into the first working setup
and inventory screens, then test persistence with a small seeded workspace.

## Week 3 (October 4-10, 2026)

Planned final-week focus: complete the core flow, verify the web fallback and
local data behavior, polish the documentation, and prepare the final demo.
