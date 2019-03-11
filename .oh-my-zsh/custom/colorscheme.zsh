# base16 builder
BASE16_BUILDER_REPO="https://github.com/InspectorMustache/base16-builder-python.git"

export BASE16_DIR="$HOME/Applications/base16-builder/output"
export BASE16_COLORSCHEME="unikitty-dark"

_build_colorschemes() {
    if ! [ -d $BASE16_DIR ]; then
        if ! [ -d $(dirname $BASE16_DIR) ]; then
            git clone -q $BASE16_BUILDER_REPO $(dirname $BASE16_DIR)
        fi

        cd $(dirname $BASE16_DIR)
        python3 pybase16.py update && \
        python3 pybase16.py build
    fi
}

set_colorscheme() {
    if [ $# -eq 1 ]; then
        export BASE16_COLORSCHEME=$1
    fi

    sh $BASE16_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh

    BASE16_XRESOURCES=$BASE16_DIR/xresources/xresources/base16-$BASE16_COLORSCHEME-256.Xresources
    if ! cmp --silent ~/.Xresources.d/colorscheme $BASE16_XRESOURCES; then
        test -f ~/.Xresources.d/colorscheme && unlink ~/.Xresources.d/colorscheme
        ln $BASE16_XRESOURCES ~/.Xresources.d/colorscheme
        which xrdb > /dev/null && xrdb .Xresources
    fi
}

# TODO: Add `set_random_colorscheme`.

_build_colorschemes
set_colorscheme
