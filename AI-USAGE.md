# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

# 1. How I used AI

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

## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - Generating Mockup Screens

- **What it gave me:** A complete mockup screens of my MVP workflow.
- **What was wrong with it:** It completely derailed from my design systems and mockup models I already established. It was in my local folder for its reference but it still made its own version of it, same palette, same neo-brutalist theme, completely different direction. Not even the logo, buttons, and other components was remotely similar in my final mockup.
- **What I did instead:** I just did it by myself screen-by-screen since the visual theme was already integrated in my Flutter project I figured it would be easy to recreate the components as Flutter widgets. It took a lot of time and effort but managed to somehow imitate my mockup design almost 1:1, not perfect but I actually liked this version more.
- **Commit:** https://github.com/28BEANS/shelf/commit/9180518c4d469f8a72c48035c1b02e9d1eb60127 (The ai-generated one was not committed and I completely trashed that version while developing on my local environment)

## 3. Who wrote what

### Written by @28BEANS (Week 1)

- **File:** `lib/theme.dart` and `lib/widgets/`
- **Commit:** https://github.com/28BEANS/shelf/commit/98be1a6067b5248484f84625972c05c2a9f3c62f
- **What it does and why it is built this way:** I made the visual system of Shelf from scratch in this commit. This includes the colors, typography, spacing, buttons, cards, text fields, branding, and other reusable widgets. I separated them into their own components because I did not want to keep repeating the same styling on every screen. It also makes it easier for me to change the overall design of the app later since most of the styling is already centralized.

### Written by @28BEANS (Week 1)

- **File:** `lib/screens/entry_screen.dart`, `lib/screens/setup_flow_screen.dart`, and `lib/screens/shell_screen.dart`
- **Commit:** https://github.com/28BEANS/shelf/commit/9180518c4d469f8a72c48035c1b02e9d1eb60127
- **What it does and why it is built this way:** I built the main user flow based on the mockups I made for Shelf. It handles the entry screen and the process of going through the workspace setup before reaching the main app. I separated the screens instead of putting everything in one file because the setup already has multiple steps and would get hard to manage if all of the UI and navigation were together.

### The AI-written part I understand best (Week 1)

- **File:** `lib/data/app_database.dart`
- **Commit:** https://github.com/28BEANS/shelf/commit/fc3fe2eb6257d5802604d8b48b5ecc86cdbc558f
- **What it does and why we kept it:** This file sets up the local database of Shelf using Drift. Basically, it defines what data an item should have, such as its ID, name, status, and the last time it was updated. It also has functions for saving an item, finding an existing item using its ID, and updating its status. I understand this part the most because the flow is pretty straightforward: the table defines what gets stored, then the functions are the operations we use to interact with that data. We kept it because Shelf is designed to be local-first, so the user's stored items should still be available even without an internet connection or after closing the app.
