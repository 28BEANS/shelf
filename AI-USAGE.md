# AI usage

## 1. How I used AI

### 2026-09-20 - Configuring Flutter platforms and dependencies

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to help configure the Shelf Flutter project for the platforms I needed and identify the packages required for the planned features of the application.
- **What it gave back:** It helped set up the Flutter platform files, update the project configuration, and add the necessary dependencies to `pubspec.yaml`.
- **What I kept, what I changed, and why:** I kept the generated platform configuration and the dependencies that were relevant to Shelf. I reviewed the package list before keeping it so that the project would not contain packages that were unnecessary for the features I was actually building.
- **Commit:** https://github.com/28BEANS/shelf/commit/ab72d61d43fd986a5e4867a5365f6a7d34b49ce6

### 2026-09-20 - Creating local database persistence

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to help me create a local-first storage setup for Shelf using Drift so that data could remain available even without relying on an online database.
- **What it gave back:** It generated the initial `AppDatabase` structure, a table for storing items, and functions for saving, reading, and updating an item's status. It also included the SQLite and Drift configuration needed for the web version.
- **What I kept, what I changed, and why:** I kept the Drift database approach and the basic save, read, and update operations because they matched the offline-first direction of Shelf. I adjusted the data fields and naming so the implementation made more sense for items that would eventually be stored and tracked inside Shelf.
- **Commit:** https://github.com/28BEANS/shelf/commit/fc3fe2eb6257d5802604d8b48b5ecc86cdbc558f

### 2026-09-20 - Structuring models, state, and scanning services

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to suggest a clean structure for the models, application state, and scanning-related logic needed for Shelf's room and inventory setup flow.
- **What it gave back:** It provided starter implementations for Shelf models, Riverpod providers, setup state, and a scanning service. This separated the application's data and logic instead of putting everything directly inside the UI.
- **What I kept, what I changed, and why:** I kept the separation between models, services, and state management because it made the project easier to maintain. I modified the generated structures and mock scanning behavior to follow Shelf's actual user flow instead of treating the AI response as the final architecture.
- **Commit:** https://github.com/28BEANS/shelf/commit/fc3fe2eb6257d5802604d8b48b5ecc86cdbc558f

### 2026-09-20 - Testing local data persistence

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to help create a test that would verify whether an item saved using Drift would still exist after the database was closed and reopened.
- **What it gave back:** It produced a persistence test that creates a temporary SQLite database, saves an item, closes the database, opens it again, checks the stored data, and tests whether the item's status can still be updated.
- **What I kept, what I changed, and why:** I kept the overall testing approach because reopening the database is a useful way of verifying real persistence rather than only checking data while the same database instance is active. I reviewed the test data, cleanup process, and expected values so they reflected the behavior I wanted Shelf to support.
- **Commit:** https://github.com/28BEANS/shelf/commit/3d7834ad9538dcf23e0da01a4e37d7870c7e4efc

### 2026-09-20 - Creating tests for the Shelf setup flow

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to help write Flutter widget tests for the main setup flow, including local sign-in, validation, room scanning, detected storage, layout selection, and section selection.
- **What it gave back:** It created widget tests that simulate user interaction with the app and verify that the correct screens appear as the user progresses through the setup process. It also added a test to make sure the sign-in fields could not be submitted while empty.
- **What I kept, what I changed, and why:** I kept the automated interaction tests because they cover important parts of the user journey. I adjusted widget keys, expected text, test data, and the mobile viewport so that the tests matched the actual Shelf interface and navigation flow.
- **Commit:** https://github.com/28BEANS/shelf/commit/3d7834ad9538dcf23e0da01a4e37d7870c7e4efc

### 2026-09-21 - Fixing fonts for offline web startup

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked AI to help diagnose and fix the web version of Shelf so that its typography would work correctly without depending on fonts being downloaded when the application starts.
- **What it gave back:** It suggested bundling Plus Jakarta Sans and Space Mono directly with the application, registering the font files in `pubspec.yaml`, updating the theme to use the local fonts, and adjusting the Flutter web bootstrap configuration.
- **What I kept, what I changed, and why:** I kept the local font approach because Shelf is intended to work reliably even when internet access is unavailable. I also kept the font license files in the repository. I reviewed the theme configuration and assigned the fonts according to Shelf's existing visual design instead of simply accepting every generated styling change.
- **Commit:** https://github.com/28BEANS/shelf/commit/f02705f3d2bac5ebc17abf7cf57a764c7c16844f

### 2026-09-24 - Persisting the workspace and inventory hierarchy

- **Tool:** ChatGPT Codex
- **What I asked for:** I had settled on a local workspace with spaces, containers, sections and items, and asked Codex for help wiring that hierarchy into Drift so it would survive closing the app.
- **What it gave back:** It proposed and implemented database tables, repository operations and Riverpod state for saving and loading those records.
- **What I kept, what I changed, and why:** I kept the local database approach because Shelf should work without an online account. I checked the saved hierarchy against the setup screens and tested that records were still there after reopening; I did not treat the generated data layer as something I had written alone.
- **Commit:** https://github.com/28BEANS/shelf/commit/15567a6

### 2026-09-25 - Connecting the inventory screens

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked Codex to help connect the item-review, section, search and detail flows to the saved records, following the screens and behavior I wanted for Shelf.
- **What it gave back:** It generated a substantial first pass of the screen and state changes in the listed files.
- **What I kept, what I changed, and why:** I used that as an implementation starting point, then checked the flows on the app and kept review separate from saving. An OCR suggestion should not become inventory until I confirm it. The feature direction and checking were mine; I am not claiming I typed the whole screen implementation from scratch.
- **Commit:** https://github.com/28BEANS/shelf/commit/b6911db

### 2026-09-26 - Adding checkout and return

- **Tool:** ChatGPT Codex
- **What I asked for:** I wanted checkout and return to record a borrower and due date without replacing the item's home location, and asked Codex to help implement that flow.
- **What it gave back:** It drafted the loan model, repository operations, screens and a repository test.
- **What I kept, what I changed, and why:** I kept a separate loan record because a borrowed item still has a home. I checked the flow and its basic validation for a missing borrower, due date and an already-active loan. The implementation was AI-assisted; the behavior I wanted and the review were mine.
- **Commit:** https://github.com/28BEANS/shelf/commit/7e68591

### 2026-09-26 - Reviewing and saving scan results

- **Tool:** ChatGPT Codex
- **What I asked for:** I asked Codex to help pass scan results into setup and inventory, but wanted uncertain storage and item detections to stay suggestions until I reviewed them.
- **What it gave back:** It changed the scan service, setup flow, persistence calls and tests to support that review step.
- **What I kept, what I changed, and why:** I kept the confirmation step because camera results can be wrong. I checked that the flow distinguishes suggestions from saved records and leaves a manual path available; I did not claim the scanning implementation itself as my solo work.
- **Commit:** https://github.com/28BEANS/shelf/commit/8d5046c

### 2026-09-27 - Connecting the iOS camera and room scan

- **Tool:** ChatGPT Codex
- **What I asked for:** I wanted the sample action replaced with a real iOS camera path, using RoomPlan or ARKit where the device supports it, and asked Codex for help with the platform bridge.
- **What it gave back:** It generated the method-channel bridge for camera capture, RoomPlan and ARKit tracking, returning results to Flutter.
- **What I kept, what I changed, and why:** I used the bridge as an AI-assisted implementation and checked the feature on an iPhone 12 mini. That test showed plane tracking and manual storage marks, not automatic cabinet recognition. I kept that limit in the app and docs instead of presenting the scan as smarter than it was.
- **Commit:** https://github.com/28BEANS/shelf/commit/8c256f8

### 2026-09-27 - Refining scan controls and geometry

- **Tool:** ChatGPT Codex
- **What I asked for:** While reviewing the scanner, I noticed the plane dimensions needed to distinguish wall height from floor depth. I asked Codex to correct that mapping and make the scan controls clearer.
- **What it gave back:** It changed the iOS geometry mapping, passed depth through to Flutter, and added a scanner contract check.
- **What I kept, what I changed, and why:** I kept separate width, height and depth values: for a horizontal plane, the second horizontal extent is depth, not wall height. I also kept the UI wording factual, since a tracked surface is not the same as a recognized cabinet.
- **Commit:** https://github.com/28BEANS/shelf/commit/19c2e9f

### 2026-09-29–30 - Photo-backed room and item views (Week 3)

- **Tool:** ChatGPT Codex
- **What I asked for:** Save room and item photos on the device, review captures, place or move storage pins, and reopen or remove saved room views.
- **What it gave back:** Drift photo and scan fields, repository/state changes, review screens, image display, and a saved-view screen.
- **What I kept, what I changed, and why:** I kept the photo-backed view and a review step before saving item suggestions. I manually refined the saved-view instructions and pin action labels so the tap-to-place behavior is clear. I required pins to be moved before their photo view can be removed, so placements are not silently lost. I describe the result as labelled photos, not a textured 3D model.
- **Commits:** [scan records](https://github.com/28BEANS/shelf/commit/8726dc4), [photo persistence](https://github.com/28BEANS/shelf/commit/1fddaf9), [capture review](https://github.com/28BEANS/shelf/commit/969068f), [view management](https://github.com/28BEANS/shelf/commit/2585aeb)

### 2026-09-30 - Non-LiDAR camera observations (Week 3)

- **Tool:** ChatGPT Codex
- **What I asked for:** Rework the iPhone 12 mini camera path around room observations and manual storage placement after dropping LiDAR from the active build.
- **What it gave back:** Changes to the iOS camera bridge, Flutter scan contract, and scan test.
- **What I kept, what I changed, and why:** I kept explicit observation types and manual placement. This does not automatically recognize shelves or cabinets.
- **Commit:** [camera observations](https://github.com/28BEANS/shelf/commit/cf8160c)

### 2026-10-01–02 - Google registration and device passcode (Week 3)

- **Tool:** ChatGPT Codex
- **What I asked for:** Replace preview login with Google registration, then use a six-digit passcode for later openings and an in-app lock action.
- **What it gave back:** A Supabase Auth service, secure local storage, entry screens, a separate Shelf 2.0 build path, and tests.
- **What I kept, what I changed, and why:** I manually refined the entry-screen wording and field labels, configured OAuth outside the repo, and checked registration, lock, relaunch, and retained workspace on my iPhone 12 mini. **Log out** locks the UI but keeps the Google session for passcode-only return. Inventory remains local.
- **Commits:** [auth service](https://github.com/28BEANS/shelf/commit/9d53a88), [separate app](https://github.com/28BEANS/shelf/commit/b5d3409), [entry flow](https://github.com/28BEANS/shelf/commit/edc2091), [tests](https://github.com/28BEANS/shelf/commit/250bd4c)

### 2026-10-02 - Branded launch scene (Week 3)

- **Tool:** ChatGPT Codex
- **What I asked for:** Show a Shelf loading scene before the passcode screen opens.
- **What it gave back:** An animated shelf scene and launch integration.
- **What I kept, what I changed, and why:** I kept the short animation after checking on the iPhone that it appears at launch and does not block the workspace after unlock.
- **Commits:** [animation](https://github.com/28BEANS/shelf/commit/da8fa69), [launch integration](https://github.com/28BEANS/shelf/commit/7d939f3)

### 2026-10-03 - Interactive login artwork (Week 3)

- **Tool:** ChatGPT Codex and image generation
- **What I asked for:** Make a 3D-style Shelf illustration that responds visibly to dragging and fits the existing card.
- **What it gave back:** A generated storage diorama, Flutter gesture and parallax code, and a widget test.
- **What I kept, what I changed, and why:** The first interaction was too subtle on the phone, so I asked for stronger movement and removal of its dark frame. I kept the revised brand colors and Reduce Motion handling after checking the drag response on device.
- **Commits:** [illustration and revision](https://github.com/28BEANS/shelf/commit/d8cee18), [motion test](https://github.com/28BEANS/shelf/commit/3896e32)

## 2. Where the AI got it wrong

### Case 1 - Generating Mockup Screens

- **What it gave me:** A complete mockup screens of my MVP workflow.
- **What was wrong with it:** It completely derailed from my design systems and mockup models I already established. It was in my local folder for its reference but it still made its own version of it, same palette, same neo-brutalist theme, completely different direction. Not even the logo, buttons, and other components was remotely similar in my final mockup.
- **What I did instead:** I just did it by myself screen-by-screen since the visual theme was already integrated in my Flutter project I figured it would be easy to recreate the components as Flutter widgets. It took a lot of time and effort but managed to somehow imitate my mockup design almost 1:1, not perfect but I actually liked this version more.
- **Commit:** https://github.com/28BEANS/shelf/commit/9180518c4d469f8a72c48035c1b02e9d1eb60127 (The ai-generated one was not committed and I completely trashed that version while developing on my local environment)

### Case 2 - Guessing which AI tool I used

- **What it gave me:** When helping me write this file, ChatGPT suggested that I used Claude Code CLI, based on a guess about my development workflow.
- **What was wrong with it:** That was not based on what I told it, and it named the wrong assistant. Tool attribution needs to be something I know, not a guess.
- **What I did instead:** I corrected the entries to say ChatGPT Codex, which is the assistant I used for this Shelf work.
- **Commit:** https://github.com/28BEANS/shelf/commit/a4e2da3

### Case 3 - Calling every new item scanned

- **What it gave me:** An empty section message that said, “No items scanned yet.”
- **What was wrong with it:** Shelf also lets people add items manually, so “scanned” made it sound like scanning was the only way to add inventory.
- **What I did instead:** I changed the message to say there are no items in the section yet and that the user can add one when ready. That wording fits both manual entry and scanning.
- **Commit:** [https://github.com/28BEANS/shelf/commit/722e72a](https://github.com/28BEANS/shelf/commit/722e72a)

### Case 4 - Login artwork looked static on the phone (Week 3)

- **What it gave me:** The first interactive diorama moved so little during a drag that it appeared stationary on the physical iPhone. That draft was not retained as a separate commit.
- **What was wrong with it:** The movement was too subtle to communicate the requested interaction, and the dark inner frame clashed with the card.
- **What I did instead:** I asked Codex to increase the visible drag response and remove the frame, then checked both changes on the iPhone. The test verifies movement and return to rest.
- **Commits:** [revised illustration](https://github.com/28BEANS/shelf/commit/d8cee18), [motion test](https://github.com/28BEANS/shelf/commit/3896e32)

### Case 5 - Fonts depended on runtime loading (Week 1)

- **What it gave me:** The AI-assisted initial package setup included `google_fonts`, which I then used in Shelf's first visual theme.
- **What was wrong with it:** That did not give the web build reliable offline typography. The app's look depended on whether those fonts were already available when it started.
- **What I did instead:** I bundled Plus Jakarta Sans and Space Mono with their licence files, registered them in `pubspec.yaml`, and switched the theme to local font families. This kept the design consistent when the browser could not fetch a font.
- **Commit:** [offline font fix](https://github.com/28BEANS/shelf/commit/f02705f)

### Case 6 - Personal name in the iOS bundle identifier (Week 1)

- **What it gave me:** The early AI-assisted iOS project setup carried a bundle identifier containing my name.
- **What was wrong with it:** The identifier would be visible in a public repository and was unnecessary for the Shelf app.
- **What I did instead:** I changed the current app and test bundle identifiers to generic Shelf identifiers. I cannot claim the old name disappeared from Git history; the current local security checklist marks that historical exposure **No**.
- **Commit:** [bundle identifier correction](https://github.com/28BEANS/shelf/commit/54c2e76)

### Case 7 - Floor depth was labelled as height (Week 2)

- **What it gave me:** The first iOS scanner bridge passed the second horizontal AR plane extent through the `height` field and had no separate depth field for surfaces.
- **What was wrong with it:** On a floor, that measurement describes depth, not wall height. A result could therefore display or save a misleading dimension.
- **What I did instead:** I kept width, height, and depth distinct in Swift and the Flutter scan contract, and added a contract check. That lets the app preserve the measurement without pretending it is a wall height.
- **Commit:** [surface geometry correction](https://github.com/28BEANS/shelf/commit/19c2e9f)

### Case 8 - Web deployment ignored the new OAuth setup (Week 3)

- **What it gave me:** The AI-assisted Pages workflow still tried to publish every push after Shelf 2.0 began requiring Supabase public configuration and a browser OAuth redirect.
- **What was wrong with it:** A successful Flutter web build would not prove the deployed sign-in worked. Publishing without the required public values could replace the earlier usable demo with an account-setup error.
- **What I did instead:** I gated the workflow on explicit OAuth readiness and public Supabase variables, passed only those public values to the web build, and kept the earlier browser demo in place. Public Shelf 2.0 browser sign-in still needs verification.
- **Commit:** [OAuth deployment gate](https://github.com/28BEANS/shelf/commit/2034c6d)

### Case 9 - Security documentation still described the old login (Week 3)

- **What it gave me:** After the Google/passcode implementation, the earlier AI-assisted privacy notes still described Shelf as having no hosted authentication.
- **What was wrong with it:** That was true of the older local-entry build but misleading as a current security description. It hid the Supabase session and the fact that **Log out** locks the UI without revoking that session.
- **What I did instead:** I added a dated Shelf 2.0 security update and revised the README setup and auth description. I kept the old section as a labelled historical snapshot and documented the remaining local-data and session limits.
- **Commits:** [security update](https://github.com/28BEANS/shelf/commit/45c3c7d), [README update](https://github.com/28BEANS/shelf/commit/925f1e3)

## 3. Who wrote what

### Written by @28BEANS (Week 1)

- **File:** `lib/theme.dart` and `lib/widgets/`
- **Commit:** https://github.com/28BEANS/shelf/commit/98be1a6067b5248484f84625972c05c2a9f3c62f
- **What it does and why it is built this way:** I made the visual system of Shelf from scratch in this commit. This includes the colors, typography, spacing, buttons, cards, text fields, branding, and other reusable widgets. I separated them into their own components because I did not want to keep repeating the same styling on every screen. It also makes it easier for me to change the overall design of the app later since most of the styling is already centralized.

### Written by @28BEANS (Week 1)

- **File:** `lib/screens/entry_screen.dart`, `lib/screens/setup_flow_screen.dart`, and `lib/screens/shell_screen.dart`
- **Commit:** https://github.com/28BEANS/shelf/commit/9180518c4d469f8a72c48035c1b02e9d1eb60127
- **What it does and why it is built this way:** I built the main user flow based on the mockups I made for Shelf. It handles the entry screen and the process of going through the workspace setup before reaching the main app. I separated the screens instead of putting everything in one file because the setup already has multiple steps and would get hard to manage if all of the UI and navigation were together.

### Written by @28BEANS (Week 2)

- **File:** `lib/screens/entry_screen.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/722e72a](https://github.com/28BEANS/shelf/commit/722e72a)
- **What it does and why it is built this way:** I updated the short explanation on the entry screen so it says these are test details for spaces saved on this device, not a real shared-account sign-in. It is a small change, but it matters because Shelf has no online account system and the screen should not promise one.

### Contributed by @28BEANS (Week 2)

- **File:** `lib/screens/inventory_screens.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/722e72a](https://github.com/28BEANS/shelf/commit/722e72a)
- **What I added and why:** I worked on the empty-section message and the “Add items” action. The screen should make it clear that an empty section is normal and that I can add items there without scanning first. That keeps the manual path easy to find.

### Contributed by @28BEANS (Week 2)

- **Files:** `lib/theme.dart` and `lib/widgets/shelf_bottom_navigation.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/92b2d7a](https://github.com/28BEANS/shelf/commit/92b2d7a)
- **What I changed and why:** I adjusted the shared button and bottom-navigation styling so the actions have clearer spacing and consistent borders. I kept those styles in the theme and navigation widget instead of styling every button separately, which makes later visual changes easier.

### Contributed by @28BEANS (Week 2)

- **File:** `lib/services/scan_service.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/19c2e9f](https://github.com/28BEANS/shelf/commit/19c2e9f)
- **What I added and why:** I made sure a scanned surface could keep its depth as a separate value from its height when the app passes it between iOS and Flutter. This matters because a floor's second measurement is depth, while a wall's is height. Keeping both fields avoids showing the wrong kind of measurement later.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/entry_screen.dart`
- **Commit:** [entry flow](https://github.com/28BEANS/shelf/commit/edc2091)
- **What I changed and why:** I manually refined the UI wording around Google registration and the six-digit passcode, including the screen descriptions, field labels, and action text. These are small screen-level edits, not a claim that I wrote the Supabase auth service. I wanted each step to tell the user clearly what happens next and to distinguish first-time setup from returning login.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/shell_screen.dart`
- **Commits:** [room-view entry](https://github.com/28BEANS/shelf/commit/e8e753c) and [logout action](https://github.com/28BEANS/shelf/commit/edc2091)
- **What I changed and why:** I manually adjusted the home screen presentation and action wording, including the room-photo preview, **Open room photo view**, **RESCAN THIS ROOM**, and the visible **LOG OUT** control. I wanted the saved room to be easy to reopen and rescan without making the home screen look like automatic shelf recognition was already available.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/room_photo_screen.dart`
- **Commit:** [saved room views](https://github.com/28BEANS/shelf/commit/2585aeb)
- **What I changed and why:** I manually refined the saved-view screen's instructions and controls, including **ADD OR EDIT PINS**, **REMOVE THIS VIEW**, and the message telling the user to move pins before deleting a photo. This made the tap-to-place behavior and the consequence of removing a view clearer. Codex helped build the underlying screen and save logic.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/setup_flow_screen.dart`
- **Commit:** [photo review](https://github.com/28BEANS/shelf/commit/969068f)
- **What I contributed and why:** I kept the captured room photo beside the storage marks in the review step, with a visible count of confirmed spots. I wanted to check where a mark appeared before accepting it, because a camera observation is still a suggestion until I review it.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/setup_flow_screen.dart`
- **Commit:** [photo review](https://github.com/28BEANS/shelf/commit/969068f)
- **What I contributed and why:** I kept the item photo, suggested names, and **Edit details** action together on the review screen. That makes it possible to compare a suggested label with the actual photo and correct it before the item is confirmed in a section.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/screens/inventory_screens.dart`
- **Commit:** [saved item images](https://github.com/28BEANS/shelf/commit/02c4322)
- **What I contributed and why:** I wanted the saved item photo to appear on search cards and item details, not only at capture time. A visible photo helps someone identify similar equipment after the original scanner session is over.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/widgets/shelf_room_photo.dart`
- **Commit:** [room photo widget](https://github.com/28BEANS/shelf/commit/969068f)
- **What I contributed and why:** I kept pins attached to positions on the image itself. The widget scales the photo to fit the screen and places each marker using its saved relative coordinates, so the same pin still points to the same storage spot when the photo is displayed at another size.

### Contributed by @28BEANS (Week 3)

- **File:** `lib/widgets/shelf_loading_animation.dart`
- **Commit:** [animated loading scene](https://github.com/28BEANS/shelf/commit/da8fa69)
- **What I contributed and why:** I chose a short Shelf-themed opening scene and checked that it appears before the account screen on the iPhone. The animation gives the app a recognizable launch while the account state loads; its motion also stops when the device requests reduced animation.

### Contributed by @28BEANS (Week 3)

- **Files:** `tools/generate_app_icons.py` and `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- **Commits:** [icon generator](https://github.com/28BEANS/shelf/commit/5e82d8e) and [updated icons](https://github.com/28BEANS/shelf/commit/8ee3266)
- **What I contributed and why:** I kept the app icon aligned with Shelf's existing logo and colors, then checked the generated iOS sizes as one set. Using the same source artwork for every required size keeps the installed icon consistent across the phone and system views.

### The AI-written part I understand best (Week 1)

- **File:** `lib/data/app_database.dart`
- **Commit:** https://github.com/28BEANS/shelf/commit/fc3fe2eb6257d5802604d8b48b5ecc86cdbc558f
- **What it does and why we kept it:** This file sets up the local database of Shelf using Drift. Basically, it defines what data an item should have, such as its ID, name, status, and the last time it was updated. It also has functions for saving an item, finding an existing item using its ID, and updating its status. I understand this part the most because the flow is pretty straightforward: the table defines what gets stored, then the functions are the operations we use to interact with that data. We kept it because Shelf is designed to be local-first, so the user's stored items should still be available even without an internet connection or after closing the app.

### The AI-written part I understand best (Week 2)

- **File:** `lib/data/inventory_repository.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/15567a6](https://github.com/28BEANS/shelf/commit/15567a6)
- **What it does and why we kept it:** The part I understand best here is `moveItem`. It first checks the item and destination, then updates the item's current section and writes a movement record inside one database transaction. The item's home section stays the same. I understand the reason for doing both writes together: if the app only changed the current section but failed to save the history, Shelf would show the new location without recording how it got there. We kept this so the current location and movement history stay in sync.

### The AI-written part I understand best (Week 3)

- **File:** `lib/services/shelf_auth.dart`
- **Commit:** [https://github.com/28BEANS/shelf/commit/9d53a88](https://github.com/28BEANS/shelf/commit/9d53a88)
- **What it does and why we kept it:** This service stores the Google session in secure device storage so I can return with a passcode. It saves a salted verifier instead of the passcode itself, checks that the current Google session belongs to the linked account, and slows repeated incorrect attempts. I understand why both checks matter: the passcode protects entry on this device, but it cannot create a Google identity by itself. Full session revocation would need another flow.

### The AI-written part I understand (Week 3)

- **File:** `lib/data/inventory_repository.dart`
- **Commit:** [photo persistence](https://github.com/28BEANS/shelf/commit/1fddaf9)
- **What it does and why we kept it:** The `removeRoomPhoto` operation loads the saved scan and checks that the requested photo exists. It refuses removal if a storage container still has a pin on that photo. Otherwise it updates the photo list, preview path, and visual status together in a database transaction. I understand why the guard belongs in the repository as well as the screen: another caller should not be able to bypass it and leave a pin referring to a deleted view.

### The AI-written part I understand (Week 3)

- **File:** `lib/screens/room_photo_screen.dart`
- **Commit:** [saved room views](https://github.com/28BEANS/shelf/commit/2585aeb)
- **What it does and why we kept it:** The pin-handling code turns a tap on the photo into a stored position. When I move an existing pin, it keeps that container's ID and changes its photo path and coordinates; when I add one, it first asks for a name and type. I kept this because the photo is a useful map only when the labels can be corrected after capture.

### The AI-written part I understand (Week 3)

- **File:** `lib/widgets/shelf_illustration.dart`
- **Commit:** [interactive illustration](https://github.com/28BEANS/shelf/commit/d8cee18)
- **What it does and why we kept it:** This widget reads pointer movement and converts it to a small translation and tilt, then returns the illustration to rest when the pointer leaves or lifts. It checks the device's Reduce Motion setting and stops the movement when that setting is on. I kept the revised response because the first version barely moved on the phone, while the final version makes the interaction visible without being required to use the login screen.

### The AI-written part I understand (Week 3)

- **File:** `tools/run_shelf_visual_device.sh`
- **Commit:** [separate device build](https://github.com/28BEANS/shelf/commit/b5d3409)
- **What it does and why we kept it:** The script makes a temporary copy of Shelf, passes only the Supabase URL and publishable key into the Flutter build, and changes the copied iOS bundle ID to `app.shelf.inventory.visual`. I understand why it builds from a copy: installing Shelf 2.0 should not replace the original Shelf app or its local data. The original project files and private values stay out of the build copy.
