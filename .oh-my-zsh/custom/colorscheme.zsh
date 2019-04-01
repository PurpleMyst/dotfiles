# base16 builder
BASE16_BUILDER_REPO="https://github.com/InspectorMustache/base16-builder-python.git"
BASE16_DIR="$HOME/applications/base16-builder/output"

export BASE16_COLORSCHEME=$(cat ~/.colorscheme)

build_colorschemes() {
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
    if [ $# -ne 1 ]; then
        echo "USAGE: $0 COLORSCHEME"
        return 1
    fi

    echo $1 > ~/.colorscheme
    export BASE16_COLORSCHEME=$1

    # set x colors
    BASE16_XRESOURCES=$BASE16_DIR/xresources/xresources/base16-$BASE16_COLORSCHEME-256.Xresources
    if [ -f $BASE16_XRESOURCES ]; then
        if [ -f ~/.Xresources.d/colorscheme ]; then
            unlink ~/.Xresources.d/colorscheme
        fi

        ln $BASE16_XRESOURCES ~/.Xresources.d/colorscheme

        if which xrdb > /dev/null; then
            xrdb ~/.Xresources
        fi
    fi

    # reload i3 colors
    if pgrep -c '^i3$' > /dev/null; then
        i3 reload > /dev/null
    fi

    # set shell colors
    if [ -f $BASE16_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh ]; then
        sh $BASE16_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh
    fi
}

if [ -f $BASE16_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh ]; then
    sh $BASE16_DIR/shell/scripts/base16-$BASE16_COLORSCHEME.sh
fi
