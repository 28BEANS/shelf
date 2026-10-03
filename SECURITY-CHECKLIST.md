# Security checklist — 2026-10-04

This checklist uses the course template. Shelf 2.0 uses Supabase Auth for Google sign-in, while workspace, room photos, inventory, and loans remain on the iPhone. A publishable Supabase key is public client configuration, not an administrator key.

## Secrets and credentials

| # | Check | Answer | Evidence |
| --- | --- | --- | --- |
| 1 | No API key, token or password is hardcoded in `lib/` | Yes | Searched tracked source for credential patterns; auth reads client configuration at build time. |
| 2 | Private values are ignored or injected; example committed | Yes | `.env` is ignored and `.env.example` lists placeholder names. The device build script extracts only URL and publishable key into its temporary Flutter config. |
| 3 | No signing credential in repository | Yes | Tracked-file review found no keystore, `key.properties`, certificate, or provisioning profile. Local Xcode signing remains on the developer machine. |
| 4 | Git history searched for credentials | Yes | Reviewed history and tracked files for password, secret, token, private-key blocks, Google API-key patterns, and database URIs; no credential value was found. |
| 5 | Committed credentials rotated | N/A | No committed credential was found, so there is nothing identified for rotation. |

## GitHub Actions

| # | Check | Answer | Evidence |
| --- | --- | --- | --- |
| 6 | No secret literal in workflow YAML | Yes | `.github/workflows/deploy-web.yml` has variable names and public config references, no credential values. |
| 7 | Private workflow credentials use Actions secrets | N/A | Current Pages workflow consumes no private credential; its future OAuth gate uses public repository variables only. |
| 8 | No secret echoed and recent run log checked | N/A | There is no private workflow secret to echo; the gated Shelf 2.0 deployment has not run with OAuth variables. I cannot claim a new run-log check. |
| 9 | Signed APK keystore decoded at build time | N/A | This repository has no signed Android APK workflow. |
| 10 | Build artifacts contain no key file | Yes | Pages uploads only the Flutter `build/web` output; the build is gated until public OAuth configuration exists and no key file is included in its artifact path. |
| 11 | Third-party actions pinned to commit SHA | Yes | The Pages workflow references action commit hashes rather than movable tags. |
| 12 | Secret scanning and push protection enabled | Yes | GitHub repository security settings/API reported both enabled on October 3. |

## Backend and security rules

| # | Check | Answer | Evidence |
| --- | --- | --- | --- |
| 13 | Firestore and Storage rules require auth | N/A | Shelf does not use Firebase Firestore or Storage. |
| 14 | Backend rules restrict users to own documents | N/A | No cloud inventory documents or storage buckets exist for this app; inventory is local. |
| 15 | Supabase RLS on every table | N/A | Shelf uses Supabase Auth only and has no application data tables to protect with RLS. |
| 16 | Firebase/Google API keys restricted | N/A | No Firebase or Google API key is compiled into Shelf; Google OAuth credentials are configured with the auth provider. |
| 17 | Signed-out app cannot access protected data | No | In-app **Log out** returns to the passcode gate, but keeps the Supabase session for passcode-only unlock. The local SQLite and photo files have no app-level encryption; a full device compromise is outside this UI gate. |
| 18 | Seed/sample data invented | Yes | Automated fixtures and mockups use invented inventory. The separately reviewed Week 2 iPhone screenshots show the owner's approved test workspace and equipment labels. |

## Input and app surface

| # | Check | Answer | Evidence |
| --- | --- | --- | --- |
| 19 | Input validated before writes | No | Key flows validate required names and loan state, but I have not audited every repository write path for length, format, and hostile input. |
| 20 | No private secret recoverable from app binary | Yes | Only Supabase URL and publishable key are passed into Flutter; the local secret key, database password, and connection URI stay out of the build. |

## Repository and privacy

| # | Check | Answer | Evidence |
| --- | --- | --- | --- |
| 21 | No personal identifier in repo or commit messages | Yes | Tracked text and recent commits were reviewed for personal email, phone, student number, and home address; none found. |
| 22 | No classmate personal data | Yes | App fixtures and published screenshots do not contain classmate information. |
| 23 | Dependencies sourced normally; generated files ignored | Yes | Flutter packages are declared in `pubspec.yaml`/lockfile; `build/` and `.dart_tool/` are ignored. |
| 24 | Assets owned, licensed, or credited | Yes | Shelf graphics and icon are project-created/AI-assisted, font license files are retained, and unverified visual research references are excluded from Git. |
| 25 | Repository visibility checked | Yes | GitHub reports `28BEANS/shelf` as public; public release and screenshot choices were reviewed for that visibility. |

## Anything I found and fixed

This review caught stale documentation that still said Shelf had no hosted authentication; the dated security note now corrects it. It also caught room-scan research images whose redistribution rights had not been verified, so those stay out of the public repository. The remaining risks are an unaudited set of write paths and local inventory that is gated by a passcode in the UI but not encrypted by Shelf itself.
