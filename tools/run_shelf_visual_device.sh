#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: tools/run_shelf_visual_device.sh <iPhone device ID|--build-only>" >&2
  exit 2
fi

device_id=$1
build_only=false
if [[ "$device_id" == "--build-only" ]]; then
  build_only=true
fi
repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
build_root=$(mktemp -d "${TMPDIR:-/tmp}/shelf-visual-device-XXXXXX")

python3 - "$repo_root/.env" "$build_root/public_env.json" <<'PY'
import json
from pathlib import Path
import sys

values = {}
for line in Path(sys.argv[1]).read_text().splitlines():
    line = line.strip()
    if not line or line.startswith('#') or '=' not in line:
        continue
    key, value = line.split('=', 1)
    values[key.strip()] = value.strip().strip('"').strip("'")
public = {
    'SUPABASE_URL': values.get('SUPABASE_URL') or values.get('URL'),
    'SUPABASE_PUBLISHABLE_KEY': values.get('SUPABASE_PUBLISHABLE_KEY') or values.get('PUBLIC_KEY'),
}
if not all(public.values()):
    raise SystemExit('Missing Supabase URL or publishable key in .env')
target = Path(sys.argv[2])
target.write_text(json.dumps(public))
target.chmod(0o600)
PY

# Build from a copy so the main Shelf bundle ID and its on-device data are safe.
rsync -a \
  --exclude='.git/' \
  --exclude='build/' \
  --exclude='.dart_tool/' \
  --exclude='.codex-*/' \
  --exclude='deliverables/' \
  --exclude='docs/' \
  --exclude='plans/' \
  --exclude='ios/Flutter/ephemeral/' \
  --exclude='ios/Pods/' \
  --exclude='ios/.symlinks/' \
  --exclude='.env*' \
  --exclude='*.keystore' \
  --exclude='*.jks' \
  --exclude='serviceAccountKey.json' \
  "$repo_root/" "$build_root/"

python3 - "$build_root" <<'PY'
from pathlib import Path
import sys

root = Path(sys.argv[1])
project = root / "ios/Runner.xcodeproj/project.pbxproj"
contents = project.read_text()
old_id = "PRODUCT_BUNDLE_IDENTIFIER = app.shelf.inventory;"
if contents.count(old_id) != 3:
    raise SystemExit("Unexpected Runner bundle IDs; refusing to install")
contents = contents.replace(
    old_id, "PRODUCT_BUNDLE_IDENTIFIER = app.shelf.inventory.visual;"
)
contents = contents.replace(
    "app.shelf.inventory.RunnerTests", "app.shelf.inventory.visual.RunnerTests"
)
project.write_text(contents)

plist = root / "ios/Runner/Info.plist"
contents = plist.read_text()
old_name = "<key>CFBundleDisplayName</key>\n\t<string>Shelf</string>"
if contents.count(old_name) != 1:
    raise SystemExit("Unexpected display name; refusing to install")
PY

echo "Building Shelf from $build_root"
cd "$build_root"
flutter pub get
flutter build ios --release --build-name=2.0.0 --build-number=8 \
  --dart-define-from-file="$build_root/public_env.json"
if [[ "$build_only" == true ]]; then
  echo "Signed Shelf build: $build_root/build/ios/iphoneos/Runner.app"
  exit 0
fi
xcrun devicectl device install app --device "$device_id" \
  "$build_root/build/ios/iphoneos/Runner.app"
xcrun devicectl device process launch --device "$device_id" \
  app.shelf.inventory.visual
