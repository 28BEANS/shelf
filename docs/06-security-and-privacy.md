# Security and privacy

This repository is public. Fill this in honestly and date it; it is checked as
part of grading.

**Last checked:** 2026-09-27

Shelf is a local, single-device MVP. No inventory data is sent to a service.
Room capture and item-label OCR run through the iOS scanning flow; the user
reviews scan suggestions before they become saved records. On September 27, the
ARKit path was exercised on an iPhone 12 mini. RoomPlan has not yet been checked
on a physical LiDAR iPhone.

## What this app stores

| Data | Where it lives | Who can see it |
| --- | --- | --- |
| Workspace name, description, setup state, and timestamps | Local Drift/SQLite database | Only the person using that device |
| Room-scan metadata and the local room model path | Local Drift/SQLite database and the app documents directory | Only the person using that device |
| Container and section names, layout positions, and optional QR identifiers | Local Drift/SQLite database | Only the person using that device |
| Item names, categories, identifiers, status, current location, and home location | Local Drift/SQLite database | Only the person using that device |
| Item images | App documents directory | Only the person using that device |
| Borrower name, due date, condition, notes, and return time | Local Drift/SQLite database | Only the person using that device |
| Scan suggestions, confidence, accepted state, and timestamps | Local Drift/SQLite database | Only the person using that device |

## Secrets

- Values the current app needs at run time: none. The current starter app and the
  local-first MVP do not call a hosted service.
- Names documented for possible future hosted work in `.env.example`:
  `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY`. These are placeholders only and
  are not currently loaded by the app.
- Where local values would live: `.env`, which is git-ignored.
- Where a future deploy workflow would get them: repository secrets. No deploy
  workflow currently needs a runtime secret.
- Anything the current deployed web build carries that a visitor could read:
  nothing beyond the public app code and fictional seed data. A future
  publishable client configuration would not be treated as a secret; privileged
  keys must never be shipped to the browser.

## What protects the data on the service side

- Nothing leaves the device in the current MVP, so there are no Firestore rules or
  Supabase RLS policies. If synchronization is added later, it must be documented
  with authenticated access and tested row-level policies before it replaces this
  local-only design.

## Checklist

- [x] `.env` and `env.json` are in `.gitignore`, and `.env.example` is committed.
- [x] I searched the repository history and current files for API keys,
  secrets, passwords and tokens. The matches were names and placeholders only;
  I found no credential value.
- [x] No service account file, keystore, or `service_role` key is present.
- [x] No service-side rules are required because the current MVP keeps data on the
  device. This must be revisited before adding synchronization.
- [x] Test fixtures and mockups use invented equipment and borrower
  information. The Week 2 iPhone screenshots use the app's real local test data
  and camera view; I reviewed this set and approved it for public sharing.
- [x] No course or university credentials are stored in the repository.
- [x] These screenshots came from my own iPhone test, and I approved them for
  public use. I will get permission before adding anyone else's information.

No key was found or revoked during this check.

The iPhone test used a real room and real equipment labels. I reviewed and
approved the 12 screenshots in `docs/assets/screenshots/week-02/` for public
sharing. The copied phone database is still outside this repository. The live
camera capture shows the manual AR path, not automatic cabinet recognition.
