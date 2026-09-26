# Proposal

## The problem, in one sentence

Small campus teams lose time locating shared equipment because an item name is
usually disconnected from its physical home in a cabinet, shelf, drawer, or
storage room.

## Who it is for

Shelf is for a small campus media organization, laboratory, or student team that
shares moderately valuable equipment in one room or cabinet. An administrator
sets up the workspace and maintains its structure; team members search for
equipment and record check-outs and returns.

The first version is not intended for personal belongings, frequently moving
household items, multi-site enterprise inventory, or continuous real-time asset
tracking.

## Core features

1. **Workspace and storage setup.** Create a workspace and scan a real room on
   a supported iPhone: RoomPlan on LiDAR devices or ARKit plus an on-device
   storage detector on non-LiDAR devices. Review the results and confirm,
   rename, retype, remove, or manually add a container.
2. **Layout and section setup.** Choose a layout such as shelves, drawers, or a
   custom arrangement. Shelf creates named sections and lets the administrator
   rename them before inventory capture.
3. **Section-based inventory capture.** Select one known section, capture real
   camera input, review only actual OCR, barcode, or validated recognition
   suggestions, then accept, edit, remove, or manually add records. Every saved
   item inherits its selected section.
4. **Browse and search.** Browse the workspace, container, section, and item
   hierarchy. Search by item, category, identifier, container, or section and
   show the item's current and home location.
5. **Loans and returns.** Record a check-out with borrower, due date, condition,
   and notes. Returning an item restores its status and records the confirmation
   time without losing its home location.
6. **Maintenance.** Rescan a room later and review suggested matches between
   newly detected containers and existing logical containers. This is stretch
   work after the core path is stable.

Automation is assistive, not authoritative. RoomPlan, ARKit, and Vision may
suggest containers, text, barcodes, or serial numbers, but a person confirms
what becomes inventory. Manual setup and item entry remain valid paths when
scanning is unavailable or incomplete. Sample detections do not appear in the
production scan flow.

## Out of scope, and why

- Multi-device synchronization and accounts are outside the MVP. The pilot is a
  local, single-device inventory for one shared equipment room.
- Advanced AR guidance, drag-and-drop editing, batch returns, QR-assisted
  returns, and room-view highlighting are stretch features. A validated
  storage-object detector is now required for semantic scanning on non-LiDAR
  phones; general recognition of every inventory item is not assumed.
- Real-time tracking is outside the product boundary because Shelf records
  confirmed locations and user actions, not a live sensor feed.
- A physical LiDAR-equipped iPhone is required to validate RoomPlan. The
  available iPhone 12 mini is the first non-LiDAR test device; a usable bundled
  detector is still required to validate semantic storage recognition. Manual
  setup keeps the workflow usable but does not prove either scanner.

## Data the app remembers, and where it is saved

The MVP uses Drift with SQLite locally. The database stores a workspace, room-scan
metadata and backend, confirmed room surfaces and storage geometry, containers,
sections, items, checkout and movement records, and reviewable scan candidates.
Captured images or room models, when retained, stay in the app's local documents
directory. The logical inventory is kept separate from the visual room scan so
a container can keep its identity and contents even if a later scan places it
somewhere else.

The expected pilot is approximately 120 relational records: one workspace, one
room scan, four containers, twelve sections, eighty items, twelve checkout
records, and about ten scan-candidate or history records. No backend is required
for the semester MVP, so separate installations do not share data.

## Risks

- **Device and model access:** RoomPlan needs supported LiDAR hardware. The
  non-LiDAR path needs an actual storage detector and device testing; ARKit
  planes alone do not identify cabinets. Confirm both prerequisites early,
  keep manual setup usable, and label untested paths as unverified.
- **Incorrect detection:** Every detected container or item is editable,
  removable, or manually addable. Confidence and review state stay visible.
- **Occluded contents:** Closed drawers or clutter can hide items. Shelf scans one
  open section at a time and supports an explicit empty or manual-entry state.
- **Stale locations:** Check-out, return, move, and later remapping preserve home
  location and history so a first scan does not become the only source of truth.
- **Scope pressure:** Build the core flow first and time-box stretch features.

## Changes since the last version

- **September 20, 2026:** Grouped the original feature list into five connected
  areas and made setup, section capture, browse/search, and basic loans the
  build-first MVP. QR, batch return, room highlighting, and remapping are now
  stretch features so the delivery boundary is explicit.
- **September 20, 2026:** Made automation reviewable and added a manual fallback
  for room setup and item entry because RoomPlan needs LiDAR hardware and visual
  detection can be wrong.
- **September 20, 2026:** Specified Drift with SQLite and the seven local record
  types so persistence can be tested early instead of remaining a technology
  choice without a data model.
- **September 26, 2026:** Revised week 2 to require real room scanning on
  LiDAR and non-LiDAR iPhones plus the complete checkout/return workflow.
  The iPhone 12 mini is the first test device; a LiDAR phone will be tested
  when available. Manual entry remains a fallback, while sample scans no
  longer count as completed scanning. This supersedes the earlier assumption
  that a custom storage detector was outside the MVP.
