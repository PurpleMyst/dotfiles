export BASE16_BUILDER_REPO='https://github.com/InspectorMustache/base16-builder-python.git'
export BASE16_OUTPUT_DIR="$HOME/applications/base16-builder/output"

if [[ -f ~/.colorscheme ]] export BASE16_COLORSCHEME=$(<~/.colorscheme)

SHELL_SCRIPT="$BASE16_OUTPUT_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh"
if [[ -f $SHELL_SCRIPT ]] sh $SHELL_SCRIPT
unset SHELL_SCRIPT

# Declare an associative array whose keys are the two-digit hex code for each
# base16 color, and whose values are the hex colors
if [[ ${commands[rg]} ]]; then
    typeset -A BASE16_HEX_COLORS=($(rg 'base([0-9A-F]+)\[\] = "([^"]+)"' -or '$1 $2' "$BASE16_OUTPUT_DIR/c_header/headers/base16-$BASE16_COLORSCHEME.h"))
fi
