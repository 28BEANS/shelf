# Security and privacy

This repository is public. Fill this in honestly and date it; it is checked as
part of grading.

**Last checked:** 2026-09-20

Shelf is currently planned as a local, single-device MVP. No inventory data is
sent to a service in the current implementation. The native scanning features
may process camera and room data on-device, and the user confirms what becomes a
saved record.

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
- [x] The repository history and current files contain no real API key, secret,
  password, or token.
- [x] No service account file, keystore, or `service_role` key is present.
- [x] No service-side rules are required because the current MVP keeps data on the
  device. This must be revisited before adding synchronization.
- [x] The planned sample data and mockups use fictional equipment and borrower
  information; no real personal data is intended for the final screenshots or
  video.
- [x] No course or university credentials are stored in the repository.
- [x] No identifiable tester data is planned. Anyone whose data is later used in
  a test must give permission first.

No key was found or revoked during this check.
