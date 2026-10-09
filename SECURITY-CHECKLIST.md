# Security checklist — updated 2026-10-09

**Audit target:** [28BEANS/shelf](https://github.com/28BEANS/shelf), including its tracked files and Git history.

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
| 7 | Private workflow credentials use Actions secrets | N/A | The Pages workflow uses only the Supabase URL and publishable client key as repository variables; it receives no private credential. |
| 8 | No secret echoed and recent run log checked | Yes | The [October 9 deployment run](https://github.com/28BEANS/shelf/actions/runs/37929326030) passed; an exact-value check found none of the private values from the local ignored `.env` in its log. |
| 9 | Signed APK keystore decoded at build time | N/A | This repository has no signed Android APK workflow. |
| 10 | Build artifacts contain no key file | Yes | Pages uploads only `build/web`. The live `.env` path returns 404, and an exact-value check found none of the private local `.env` values in the published JavaScript. The public Supabase URL and publishable key are expected in the client bundle. |
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
| 21 | No student number, personal email, phone number or home address in repository or commit messages | No | The current identifier is generic, but an older iOS bundle identifier containing my name remains visible in Git history in the change at `54c2e76`. I found no student number, phone number or home address in tracked project files. |
| 22 | No classmate personal data | Yes | App fixtures and published screenshots do not contain classmate information. |
| 23 | Dependencies sourced normally; generated files ignored | Yes | Flutter packages are declared in `pubspec.yaml`/lockfile; `build/` and `.dart_tool/` are ignored. |
| 24 | Assets owned, licensed, or credited | Yes | Shelf graphics and icon are project-created/AI-assisted, font license files are retained, and unverified visual research references are excluded from Git. |
| 25 | Repository visibility checked | Yes | GitHub reports `28BEANS/shelf` as public; public release and screenshot choices were reviewed for that visibility. |

## Anything I found and fixed

This review caught stale documentation that still said Shelf had no hosted authentication; the dated security note now corrects it. It also caught room-scan research images whose redistribution rights had not been verified, so those stay out of the public repository. The current iOS identifier is generic, but an older identifier containing my name remains in Git history, so row 21 is **No**. The remaining risks are unaudited write paths and local inventory gated by a passcode in the UI but not encrypted by Shelf itself.

On October 9, GitHub Pages deployed Shelf 2.0 from commit `3dd7b6c`. The public
sign-in screen loaded in a browser. The owner reports testing browser sign-in
and account deletion in the current build; the deployment check did not repeat
those account actions.
