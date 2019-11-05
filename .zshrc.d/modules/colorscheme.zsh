BASE16_BUILDER_REPO="https://github.com/InspectorMustache/base16-builder-python.git"
BASE16_OUTPUT_DIR="$HOME/applications/base16-builder/output"

BASE16_COLORSCHEME=$(cat ~/.colorscheme)
export BASE16_COLORSCHEME

[ -f "$BASE16_OUTPUT_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh" ] && sh "$BASE16_OUTPUT_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh"

# Declare an associative array whose keys are the two-digit hex code for each
# base16 color, and whose values are the hex colors
typeset -A BASE16_HEX_COLORS=($(rg 'base(\d+)\[\] = "([^"]+)"' -or '$1 $2' "$BASE16_OUTPUT_DIR/c_header/headers/base16-$BASE16_COLORSCHEME.h"))
