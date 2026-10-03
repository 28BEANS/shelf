# Visual workspace and item scanning: implementation plan

**Scope update, October 3:** Shelf 2.0 now targets non-LiDAR iPhones only.
RoomPlan/LiDAR steps below are historical proposals, not active work. Saved
photo views with movable storage pins are the current visual result; textured
3D reconstruction remains an unvalidated feasibility goal. A saved view can be
removed after its pins have been moved. Google registration through Supabase and
a six-digit device passcode are the current account flow.

**Status:** Proposed workflow and build plan, September 29, 2026. This describes the requested experience; the reference pictures are examples supplied by the user, not screenshots of a working Shelf feature.

## The experience to build

1. Create or open a workspace and choose **Scan space**.
2. Walk around the workspace with the iPhone camera. Shelf shows capture coverage and asks for more views where necessary.
3. Open a saved, navigable visual model of the space. Tap a cabinet, shelf, or another visible storage location; place a marker; enter a name such as **Cabinet** or **Shelf 1**; and confirm it. Repeat for each storage location. The user's marker and name are authoritative even if automatic detection makes a suggestion.
4. The workspace card shows a preview of that saved space. Opening it reveals the same model and its named markers. Tapping a marker opens that container and its sections.
5. Choose or create sections inside a container, such as **Top shelf** and **Bottom shelf**. Select a section before scanning its contents.
6. Aim the camera at one item and capture it. Shelf proposes an object name such as **notebook** or **pen**, reads any visible text or barcode, and shows the captured photo. The user corrects the name and details, chooses the item photo or crop, and confirms the section.
7. Shelf saves the item and photo. That real photo becomes its thumbnail in the section, search results, and item detail. Existing move, checkout, and return actions continue to refer to the same item.
8. A later room rescan preserves existing container, section, and item identities. The user reviews where old markers belong on the new visual model before replacing the previous view.

The camera never silently adds storage or inventory records. A review and confirm action closes each scan flow.

## Visual references

### Requested end-to-end space flow

Reference A, supplied for planning: the user scans a space, taps a cabinet
in the visual view, names it, and sees the saved workspace with that container.
It illustrates the desired interaction, not an implemented screen.

### Desired room-view quality

References B–D, supplied for planning, showed textured dollhouse room views.
They are quality references. Merely detecting AR planes or saving a still
photo does not meet that visual goal. The source rights for the supplied
images are unverified, so the image files are kept local and are not
redistributed in this public repository.

## What exists now and what must change

| Area | Current Shelf behavior | Required change |
| --- | --- | --- |
| Non-LiDAR space scan | ARKit tracks horizontal/vertical planes and lets the user aim a center reticle and press **Mark storage**. | Capture a persistent visual asset; let the user tap directly in its review view; save the marker's position and name. |
| LiDAR space scan | RoomPlan returns room surfaces and some furniture/storage geometry. | Render and retain a viewable room model with annotations. Add imagery/texturing if the target is the photorealistic look in the references. |
| Space review | A list of storage marks can be renamed, confirmed, or removed. | Add a visual review screen tied to that list; editing either view updates the same marker. |
| Workspace home | Shows a generic space illustration and container list. | Show a preview of the saved room asset and open its annotated viewer. |
| Item scan | One still image is processed for OCR and barcodes; suggestions are text records. | Add object recognition, a photo crop, and a single item review card that combines the signals. |
| Item storage | Items and scan candidates have no image reference. | Keep confirmed item photos in app storage and link them to item records; manage discarded captures. |

## Technical boundary for iPhones without LiDAR

ARKit can track the camera, find some flat surfaces, and place markers without LiDAR. The existing iPhone 12 mini path already demonstrates plane tracking and manual marking. Those ARKit results are sparse geometry and **cannot by themselves produce the textured dollhouse model shown above**.

The complete visual target needs a separate multi-view reconstruction step: collect overlapping photos or video frames, reconstruct a textured model, and display it in a 3D viewer. This can work from ordinary camera imagery in principle, but quality depends on coverage, lighting, reflective/blank surfaces, and processing capacity. The plan must choose and validate a reconstruction engine and processing location. Shelf's current local-only app has neither an engine nor a server for this. Treat that choice as an implementation gate, not as an already solved ARKit feature.

For delivery, keep two explicitly labeled outputs:

- **Visual room model available:** show the textured model and allow direct taps on its geometry. This is the target represented by the references.
- **Visual model unavailable or still processing:** show captured room photos with tappable image pins, alongside the ARKit surface map and existing manual storage flow. Preserve names and inventory; let the user retry reconstruction. Never present a sparse plane map as a finished textured scan.

The LiDAR path also needs a visual asset/export and viewer. RoomPlan's structured room geometry is useful for dimensions and furniture suggestions, but a photo-realistic texture still needs image capture and mapping.

## Implementation sequence

### 1. Define the scan and media contracts

- Extend the scanner response beyond `surfaces` and `storage`: scan ID, capture status, camera pose/coordinate system, preview image, optional model file, format, and processing errors.
- Define stable marker data: container ID, room scan ID, marker name/type, 3D position when available, optional mesh hit or surface anchor, optional 2D photo coordinates, and confirmation state. Keep marker identity separate from the room mesh so a rescan does not erase its inventory.
- Define an item-capture result with original photo, chosen crop/thumbnail, object-label suggestions, OCR text, barcode values, source, and confidence. Keep the crop linked to the same captured item.
- Save media files under app-managed storage. Keep relative file references and metadata in Drift/SQLite; do not put large image or model bytes in database rows. Migrate existing databases with nullable fields so old spaces and items still load.

**Done when:** an existing Shelf database opens, old inventory remains intact, and a scan can save and reopen its preview, model metadata, markers, and item photo references.

### 2. Capture and reconstruct the space

- Retain the current ARKit path for live camera tracking and surface finding on supported non-LiDAR iPhones. Capture enough overlapping imagery for reconstruction and show coverage guidance, progress, cancel, and retry states.
- Retain RoomPlan on supported LiDAR iPhones for structured walls and objects. Capture imagery needed for a textured visual presentation as a separate step.
- Evaluate a concrete photogrammetry/reconstruction engine using a real non-LiDAR iPhone capture of the intended small workspace. Decide whether processing occurs on-device, on a local companion computer, or through an explicit upload service. Record processing time, output size, visual quality, privacy behavior, and cost before committing to that path.
- Produce a portable view asset, a thumbnail for the workspace card, and a status of `processing`, `ready`, or `failed`. Keep the capture photos or an image-based fallback when reconstruction fails.

**Done when:** a room captured on the target non-LiDAR iPhone can be reopened as a textured, navigable model matching the interaction in Reference A, or is honestly shown in a clearly labeled photo fallback. This is the major technical feasibility milestone.

### 3. Build the visual review and naming flow

- Add a room viewer with pan, orbit, zoom, reset, and visible storage markers. Tapping the rendered model performs a hit test and creates a marker at the selected position. For photo fallback, tapping records a pin tied to that photo.
- Open a concise editor for the selected marker: **Name**, **Type** (cabinet, shelf, drawer, rack, other), **Confirm**, **Move pin**, and **Remove**. If an automatic storage detector supplies a suggestion, show it as editable text.
- Link every visual marker to one logical `StorageContainer`; the list and model must stay in sync. Do not require an automatic cabinet classifier before manual naming works.
- After saving, show the scan preview on **Your Spaces**. Opening the workspace shows its annotated view; opening a marker shows its sections. A workspace with no visual asset still shows its container list.

**Done when:** on a non-LiDAR iPhone, a user can tap a cabinet in the saved visual view, name it **Cabinet**, close and reopen Shelf, and retrieve the same marker and container from the workspace card.

### 4. Recognize and save individual items

- Keep OCR and barcode detection as useful signals. Add an object recognition model or service trained/validated for Shelf's intended inventory, including notebook, pen, and the actual equipment used by the pilot team. A generic classifier may return a broad label; expose that as a suggestion.
- Start with **one item per capture** to make the saved photo and detected name unambiguous. Allow the user to crop or retake the image, edit the name/category/identifier, and confirm the destination section. Add multi-item detection only after the one-item flow is reliable.
- Store the confirmed image and a thumbnail; show it on review, item detail, section cards, and search results. Items added manually may also receive a photo; older items without photos use a placeholder.
- Clean up rejected or abandoned temporary captures. Replacing an image updates its reference without changing the item ID, location history, or loan records.

**Done when:** scanning a notebook produces an editable **notebook** suggestion and real-photo preview, and the confirmed item appears with that photo in the selected section after app restart. If recognition is uncertain, the user can name it manually without losing the photo.

### 5. Rescan and preserve inventory

- Save a new room scan as a separate version. Match old and new storage markers by position and context only as suggestions; require user confirmation before remapping.
- Keep container, section, and item IDs stable. If a container moved or was hidden from the new scan, let the user place its existing marker on the new model or leave it unplaced. Archive the previous visual asset until the new mapping is confirmed.

**Done when:** rescanning a room changes its visual view while **Cabinet**, its sections, items, photos, and loan history remain accessible.

## Build order and decision gates

1. **Feasibility spike:** capture one real small workspace on the iPhone 12 mini; prove the chosen non-LiDAR reconstruction route can produce a usable textured view and tap coordinates. This determines the viewer/model format and whether a processing service is needed.
2. **Persistent visual space:** schema migration, capture assets, viewer, tap-to-name markers, workspace card preview, and reopening after restart.
3. **Photo-backed item capture:** object suggestions, OCR/barcode merge, review/edit, item photo storage, and thumbnails throughout inventory.
4. **Rescan/remap:** keep logical inventory stable while replacing the visual model.
5. **Polish and device checks:** incomplete scans, no-texture/photo fallback, low light, reflective surfaces, permission denial, interrupted processing, storage pressure, and older records.

If the feasibility spike cannot produce an acceptable textured model on the available hardware and processing setup, the project should explicitly ship the tappable photo/AR placement experience first and keep the 3D reconstruction target open. The card and review screens must say **photo view** or **AR map** in that case.

## Key product decisions to settle during the spike

- **Processing location:** local-only processing preserves the app's current privacy model; a remote reconstruction service requires clear upload consent, retention/deletion rules, connectivity handling, and operating costs.
- **Room asset format and viewer:** choose a format supported by the selected reconstruction output and a mobile viewer capable of stable hit tests. Use the same world coordinates for 3D markers and room geometry.
- **Item recognition vocabulary:** choose a model and measure it on the pilot team's real items; support broad or uncertain labels through review rather than claiming exact identification.
- **Storage budget:** set limits for raw frames, model files, full item photos, and thumbnails; define when temporary files are deleted and how backup/restore handles media references.

## Acceptance walkthrough

On the target non-LiDAR iPhone, create a new workspace, scan a real room, open its saved visual view, tap a cabinet, name it **Cabinet**, add **Shelf 1**, scan a notebook into that section, accept or correct the suggested name, and save its real photo. Quit and reopen the app. The workspace preview, cabinet marker, section, notebook thumbnail, and item location must all still work. Repeat with an uncertain item label to prove manual correction. On a LiDAR device, repeat the room portion using RoomPlan. Finally, rescan and verify that existing inventory survives remapping.

This walkthrough is the product acceptance target, not evidence that the new features already pass today.

## Platform references

- [Apple ARKit: tracking and visualizing planes](https://developer.apple.com/documentation/ARKit/tracking-and-visualizing-planes) describes camera-based surface tracking and AR placement.
- [Apple RoomCaptureSession.isSupported](https://developer.apple.com/documentation/RoomPlan/RoomCaptureSession/isSupported) identifies LiDAR as the requirement for RoomPlan capture.

## October 3 implementation status

The current Shelf 2.0 build saves camera room views on the non-LiDAR ARKit
path. A person can reopen those views, add or move named storage pins, remove
an unpinned view, and rescan without replacing existing container, section,
item, or loan records. Item capture can retain a real photo alongside OCR
review suggestions. These outcomes were checked in automated tests and in the
separate signed Shelf 2.0 app on an iPhone 12 mini.

The result is a **photo view**, not a textured 3D reconstruction. There is no
photogrammetry engine or validated automatic storage detector in this build.
The earlier RoomPlan/LiDAR steps above remain historical planning notes after
the October 3 scope change. Their acceptance criteria must not be marked
complete for this version.
