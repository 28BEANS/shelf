# Weekly reports

## Week 1 (September 20-26, 2026)

**Done this week**

- Reviewed the revised proposal, mockup, and design-system source materials.
- Added the mockup screens, design-system visuals, and reference PDFs to
  `docs/assets/` so the project documentation can render from the repository.
- Documented the local-first MVP boundary, the logical inventory hierarchy, and
  the manual fallback for uncertain detection.

**In progress**

- Preparing reusable UI building blocks for the Flutter app, including the
  primary action button, text field, bottom navigation, section card, item
  location card, status chip, scan-candidate tile, and empty state.
- Establishing `lib/theme.dart` around the Shelf color scheme, type scale,
  spacing tokens, card shape, and button defaults.

**Blocked or stuck on**

- RoomPlan validation depends on access to a compatible LiDAR-equipped iPhone or
  iPad. The manual setup path will remain usable if that hardware is unavailable.
- Backend work has not started; this is intentional while the visual foundation
  is being prepared.

**Decisions made, and why**

- Use a light-only, semantic Material theme so every screen can share the lime,
  lavender, mint, warm background, and near-black outline roles.
- Keep automation reviewable and provide manual alternatives because scan results
  may be incomplete or wrong.
- Build the UI foundation before persistence and native scanning so later screens
  can reuse stable widgets instead of inventing one-off styles.

**Hours spent, roughly:** To be updated at the end of the week.

**Next week I will:**

- Finish the reusable widget and theme implementation.
- Start the workspace and container setup flow from the mockup.
- Begin the Drift schema and persistence spike after the visual foundation is
  stable.

## Week 2 (September 27-October 3, 2026)

Planned focus: continue from the visual foundation into the first working setup
and inventory screens, then test persistence with a small seeded workspace.

## Week 3 (October 4-10, 2026)

Planned final-week focus: complete the core flow, verify the web fallback and
local data behavior, polish the documentation, and prepare the final demo.
