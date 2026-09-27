# Shelf

[![Made with AI](https://img.shields.io/badge/Made_with-AI_assistance-blue)](AI-USAGE.md)

Shelf is a local inventory app for a shared equipment room. It saves the room's
storage layout and items on the device, so a team can search for equipment,
check it out, move it, and return it to its home section.

**Live app:** <https://28beans.github.io/shelf/>

**Source:** <https://github.com/28BEANS/shelf>

## How to run it

The project was built with Flutter 3.44.4 and Dart 3.12.2. In a terminal:

```bash
git clone https://github.com/28BEANS/shelf.git
cd shelf
flutter pub get
flutter run -d chrome
```

The app opens to the Shelf entry screen. It does not contact an account server;
any non-empty email and password opens the local app. No API key or `.env` file
is needed.

To run the iOS app, open `ios/Runner.xcworkspace` in Xcode and select a device.
Camera and room scanning need a physical iPhone. A simulator can check the
non-camera screens, but it cannot verify room tracking or camera results.

## What you can do

1. Create a local workspace and add or scan storage containers. Review room
   results, rename them, choose a layout and edit the sections.
2. Select a section, add an item manually or capture a label on iPhone. OCR
   results become suggestions; review or edit them before confirming inventory.
3. Search for an item by its name, model, identifier, category or location.
   Open its details to see its current and home section.
4. Move an item to another section, or check it out with a borrower and due
   date. Returning it records the return and keeps the history.

The browser version supports the manual setup, inventory, search and loan flow.
Camera capture is only available on iOS. Data is stored locally with
Drift/SQLite; there is no cloud sync or shared login.

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

## What I built this week

Week 2 connected the screens to a local database for workspaces, scans,
containers, sections, items, loans, candidates and item moves. Closing and
reopening the app keeps the saved inventory. The review screen only saves
accepted suggestions, and moving an item keeps its original home location.

I also tested the iOS ARKit path on an iPhone 12 mini. It tracked a room plane
and let me mark storage by hand. Camera OCR produced item suggestions that I
reviewed and corrected before saving. I checked checkout, return, move and data
after relaunch on that phone.

## Scan limits

The iPhone 12 mini test confirms room-plane tracking and manual spatial marks;
it does not confirm automatic recognition of cabinets or shelves. The app has
no suitable licensed storage-detection model bundled, so that feature remains
unavailable. RoomPlan has not been tested on a physical LiDAR iPhone. OCR names
were imperfect and needed correction. Barcode capture and scan failure cases
still need testing.

On Chrome, camera scanning is unavailable and the manual flow is the usable
route. Do not treat the browser demo as scanner evidence.

## Project structure

```text
lib/
├── main.dart                 # app entry point
├── app.dart                  # app setup and local database providers
├── theme.dart                # Shelf colors, type and widget styles
├── data/                     # Drift schema and inventory repository
├── models/                   # workspace and inventory records
├── screens/                  # entry, setup, search, item, move and loan screens
├── services/                 # iOS scanner bridge and scan results
├── state/                    # Riverpod providers and local state
└── widgets/                  # reusable Shelf controls and navigation
```

## Checks

The Week 2 code was checked with:

```bash
flutter analyze
flutter test
flutter build web --release
flutter build ios --simulator --no-codesign
```

All 10 automated tests passed, static analysis found no issues, and both web and
iOS simulator builds succeeded. The physical-device results above were checked
separately on the iPhone 12 mini.

## Privacy and security

Shelf stores workspace and inventory records on the device. It does not send
them to a server. The public repository has no app API key or backend secret;
see the [security and privacy notes](docs/06-security-and-privacy.md). The
[AI usage record](AI-USAGE.md) describes how AI tools were used on the project.

## More project notes

- [Proposal and scope](docs/01-proposal.md)
- [Mockup and screen flow](docs/02-mockup.md)
- [Design system](docs/03-design-system.md)
- [Weekly project reports](docs/04-weekly-reports.md)
- [Security and privacy](docs/06-security-and-privacy.md)

## Next

I still need to test RoomPlan on a LiDAR iPhone, find a suitable licensed model
for automatic storage recognition, exercise barcode and scanner failure cases,
complete the Chrome walkthrough from a clean start, and record the final demo.

**AI use:** I used ChatGPT Codex throughout planning, implementation, tests and
documentation. I reviewed its output and made the final calls. See
[`AI-USAGE.md`](AI-USAGE.md) for the record. Shelf is MIT licensed; see
[`LICENSE`](LICENSE).
