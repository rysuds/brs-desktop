#!/usr/bin/env bash
set -euo pipefail

APP_DIR="${1:?Usage: package-app.sh <app-directory> [output.zip]}"
OUTPUT="${2:-${APP_DIR%/}.zip}"

if [ ! -f "$APP_DIR/manifest" ]; then
    echo "Error: No manifest found in $APP_DIR" >&2
    exit 1
fi

if [ ! -d "$APP_DIR/source" ]; then
    echo "Error: No source/ directory found in $APP_DIR" >&2
    exit 1
fi

ORIG_DIR="$(pwd)"
OUTPUT_ABS="$(cd "$(dirname "$OUTPUT")" && pwd)/$(basename "$OUTPUT")"

rm -f "$OUTPUT_ABS"

cd "$APP_DIR"

ENTRIES=(manifest source/)
for dir in components images fonts themes assets; do
    [ -d "$dir" ] && ENTRIES+=("$dir/")
done

zip -0 -X -r "$OUTPUT_ABS" "${ENTRIES[@]}"

cd "$ORIG_DIR"

echo ""
echo "Packaged: $OUTPUT"
echo "Verifying compression compatibility..."

python3 -c "
import zipfile, sys
ok = True
with zipfile.ZipFile(sys.argv[1]) as z:
    for i in z.infolist():
        if i.compress_type not in (0, 8):
            print(f'  FAIL: {i.filename} uses compress_type={i.compress_type}')
            ok = False
        else:
            print(f'  OK: {i.filename} (type={i.compress_type})')
if not ok:
    print('ERROR: Archive contains incompatible entries')
    sys.exit(1)
print('All entries compatible with brs-engine')
" "$OUTPUT_ABS"
