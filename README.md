# Shelf

[![Made with AI](https://img.shields.io/badge/Made_with-AI_assistance-blue)](AI-USAGE.md)

Shelf is an iPhone inventory app for a shared equipment room. It keeps room
views, storage locations, items, moves, and loans on one device so a user can
find equipment and return it to its home section. The current Shelf 2.0 build
uses Google registration through Supabase Auth and a six-digit passcode for
returning to that device; inventory is not synced to Supabase.

**Source:** <https://github.com/28BEANS/shelf>
**Public browser demo:** <https://28beans.github.io/shelf/> — the earlier
manual-flow build. The current Google sign-in version has not been verified on
Pages, and the workflow is gated until public OAuth setup and a browser check
are complete.

## Setup and installation

I built this version with Flutter 3.44.4 and Dart 3.12.2. The iPhone build also
needs Xcode, CocoaPods, a personal Xcode development team, and a physical iPhone
for camera scanning.

```bash
git clone https://github.com/28BEANS/shelf.git
cd shelf
flutter pub get
cp .env.example .env
```

Set `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` in the ignored `.env`.
The device build script also accepts `URL` and `PUBLIC_KEY`. Use only the
publishable client key; never put the Supabase secret key, database password, or
connection URI in Flutter or Git. In Supabase, enable Google Auth with a Google
Cloud Web application OAuth client. Add the callback URL shown by Supabase to
the Google client's authorized redirect URIs, and add
`app.shelf.inventory.visual://login-callback/` to Supabase Auth's redirect
allow list. These settings live outside this repository.

## How to run it

Connect an iPhone with Developer Mode and configure Xcode signing. Find its
device ID with `flutter devices`, then install the separate Shelf 2.0 bundle:

```bash
tools/run_shelf_visual_device.sh <iPhone-device-ID>
```

Use `tools/run_shelf_visual_device.sh --build-only` for a signed build without
installation. The script creates a temporary copy with a distinct bundle ID,
so the original Shelf installation remains separate. On first launch, choose
**Continue with Google**, create and confirm a six-digit passcode, then unlock.
Later launches and **Log out** return to the passcode screen. **Log out** locks
the app; it does not revoke the stored Google session.

A simulator can show non-camera screens but cannot verify room tracking or
camera results. The public browser link is the earlier manual demo. A fresh
local Chrome run of this source needs public OAuth values passed as Dart
defines and working web redirect configuration; that complete browser
sign-in path has not yet been verified.

## Features and usage

1. Register with Google, set the device passcode, and unlock the local workspace.
2. Create a workspace. Capture room photos on iPhone or use the manual setup
   route. Review observations, name storage containers, choose layouts, and
   adjust sections before saving.
3. Open a saved room photo view to place or move storage pins. Move pins off a
   view before deleting that photo. The view is a labelled image, not a textured
   3D room model.
4. Add an item to a section manually, or capture an item photo and review/edit
   the OCR suggestion before accepting it.
5. Search by item, model, identifier, category, or location. Item details show
   both current and home sections.
6. Move an item, check it out with borrower and due date, or return it. Shelf
   keeps movement and loan history in local Drift/SQLite records.

## Screenshots

I captured these 12 Week 2 screens on my iPhone 12 mini on September 27. They
show the saved inventory, item review, search, setup and loan screens, plus the
live AR camera view. I checked this set and approved it for public sharing.

| Spaces home | Container sections | Item details |
| --- | --- | --- |
| ![Spaces home](docs/assets/screenshots/week-02/01-spaces-home.png) | ![Container sections](docs/assets/screenshots/week-02/02-container-sections.png) | ![Item details](docs/assets/screenshots/week-02/03-item-details.png) |

| Camera item review | Choose layout | Add inventory |
| --- | --- | --- |
| ![Camera item review](docs/assets/screenshots/week-02/04-camera-item-review.png) | ![Choose layout](docs/assets/screenshots/week-02/05-layout-selection.png) | ![Add inventory](docs/assets/screenshots/week-02/06-add-inventory.png) |

| Inventory search | Storage review | Edit container |
| --- | --- | --- |
| ![Inventory search](docs/assets/screenshots/week-02/07-inventory-search.png) | ![Storage review](docs/assets/screenshots/week-02/08-storage-review.png) | ![Edit container](docs/assets/screenshots/week-02/09-edit-container.png) |

| Scan workspace | Check out item | Live AR camera scan |
| --- | --- | --- |
| ![Scan workspace](docs/assets/screenshots/week-02/10-scan-workspace-preview.png) | ![Check out item](docs/assets/screenshots/week-02/11-checkout-item.png) | ![Live AR camera scan](docs/assets/screenshots/week-02/12-live-camera-ar-scan.png) |

The earlier Week 1 screens show the entry, home, search and first setup flow:

| Entry | Home | Add inventory |
| --- | --- | --- |
| ![Shelf entry screen](docs/assets/screenshots/01-sign-in.png) | ![Workspace home](docs/assets/screenshots/02-spaces.png) | ![Add inventory](docs/assets/screenshots/03-add-inventory.png) |

| Search | Room scan | Review detected spaces |
| --- | --- | --- |
| ![Search screen](docs/assets/screenshots/04-search.png) | ![Room scanning screen](docs/assets/screenshots/05-room-scan.png) | ![Detected spaces](docs/assets/screenshots/06-detected-spaces.png) |

| Choose layout | Select section | Review item suggestions |
| --- | --- | --- |
| ![Layout selection](docs/assets/screenshots/07-choose-layout.png) | ![Section selection](docs/assets/screenshots/08-select-section.png) | ![Item review](docs/assets/screenshots/09-review-items.png) |

## Current limits and next steps

The iPhone 12 mini test confirmed a real camera feed, room-plane tracking,
manual storage marks, OCR suggestions, saved items, and retained data after
relaunch. It did not establish automatic shelf/cabinet recognition. The active
Shelf 2.0 room experience is photo-backed and does not use LiDAR or produce a
textured 3D model. OCR needs human review. Barcode capture, scanner failure
cases, and a full write-path validation audit remain open.

The gallery above documents Weeks 1 and 2. Current Shelf 2.0 login, launch,
and room-photo screens have not yet been captured and reviewed for publication,
so the one-current-screenshot-per-screen documentation criterion is still
incomplete. The final demo video, slides, and square image also remain open.
The public Pages build still shows the earlier browser demo.

## Project structure

```text
lib/
├── main.dart                 # Supabase initialization and app entry
├── app.dart                  # app setup and database providers
├── theme.dart                # colors, typography, and shared styles
├── data/                     # Drift schema and inventory repository
├── models/                   # workspace, scan, item, and loan records
├── screens/                  # entry, setup, photo view, inventory, and loans
├── services/                 # Google/passcode auth and iOS scan bridge
├── state/                    # Riverpod providers and setup state
└── widgets/                  # reusable controls, images, and navigation
```

## Verification and project records

The source was checked on October 4 with `flutter analyze`, 17 Flutter
tests, and a release web build. The owner verified Google registration,
passcode unlock after relaunch, retained workspace, and the illustration drag
response on an iPhone 12 mini. The web build check is not an OAuth browser
test.

- [Week 3 implementation report](docs/04-weekly-reports.md)
- [Security checklist](SECURITY-CHECKLIST.md) and [privacy notes](docs/06-security-and-privacy.md)
- [Proposal](docs/01-proposal.md), [mockup](docs/02-mockup.md), and [design system](docs/03-design-system.md)
- [Visual scan scope and remaining work](docs/07-visual-scan-implementation-plan.md)

**AI use:** I used ChatGPT Codex extensively for implementation, tests, and
documentation, plus image generation for the login artwork. I set the
requirements, reviewed the results, and tested the device flow. The
[AI usage record](AI-USAGE.md) gives feature commits, mistakes, and authorship
details. Shelf is MIT licensed; see [LICENSE](LICENSE).
