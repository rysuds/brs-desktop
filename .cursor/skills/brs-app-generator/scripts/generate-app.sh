#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

TEMPLATE=""
TITLE="My BrightScript App"
OUTPUT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --template|-t) TEMPLATE="$2"; shift 2;;
        --title|-n)    TITLE="$2";    shift 2;;
        --output|-o)   OUTPUT="$2";   shift 2;;
        --help|-h)
            echo "Usage: generate-app.sh --template <type> --title <title> [--output <file>]"
            echo ""
            echo "Templates:"
            echo "  dashboard   Streaming TV-style layout with hero banner and content cards"
            echo "  animation   Bouncing colored shapes with smooth animation"
            echo "  game        Paddle-and-ball arcade game with score tracking"
            echo ""
            echo "Options:"
            echo "  --template, -t   Template type (required)"
            echo "  --title, -n      App title shown in header (default: 'My BrightScript App')"
            echo "  --output, -o     Output file path (default: <template>_app.brs)"
            exit 0
            ;;
        *) echo "Error: Unknown option '$1'. Use --help for usage."; exit 1;;
    esac
done

if [[ -z "$TEMPLATE" ]]; then
    echo "Error: --template is required."
    echo "Available templates: dashboard, animation, game"
    echo "Run with --help for details."
    exit 1
fi

TEMPLATE_FILE="$SKILL_DIR/assets/${TEMPLATE}.brs"

if [[ ! -f "$TEMPLATE_FILE" ]]; then
    echo "Error: Unknown template '$TEMPLATE'."
    echo "Available templates: dashboard, animation, game"
    exit 1
fi

if [[ -z "$OUTPUT" ]]; then
    OUTPUT="${TEMPLATE}_app.brs"
fi

sed "s|APP_TITLE|${TITLE}|g" "$TEMPLATE_FILE" > "$OUTPUT"

echo "Generated: $OUTPUT"
echo "  Template: $TEMPLATE"
echo "  Title:    $TITLE"
echo ""
echo "To run in the BrightScript Simulator:"
echo "  1. Open View -> Code Editor in the simulator"
echo "  2. Paste the contents of $OUTPUT into the editor"
echo "  3. Click the Run button"
