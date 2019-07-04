BASE16_BUILDER_REPO="https://github.com/InspectorMustache/base16-builder-python.git"
BASE16_OUTPUT_DIR="$HOME/applications/base16-builder/output"

BASE16_COLORSCHEME=$(cat ~/.colorscheme)
export BASE16_COLORSCHEME

[ -f "$BASE16_OUTPUT_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh" ] && sh "$BASE16_OUTPUT_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh"
