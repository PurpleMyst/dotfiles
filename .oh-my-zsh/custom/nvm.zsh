export NVM_DIR="${NVM_DIR:=$HOME/.nvm}"

if [ -d "$NVM_DIR" ]; then
    NODE_GLOBALS=(node nvm)

    if [ -d "$NVM_DIR/versions/node" ]; then
        NODE_GLOBALS+=(`find $NVM_DIR/versions/node/ -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort -u`)
    fi

    load_nvm() {
        unset -f $NODE_GLOBALS
        test -f "$NVM_DIR/nvm.sh"  && source "$NVM_DIR/nvm.sh"
    }

    for cmd in "${NODE_GLOBALS[@]}"; do
        eval "$cmd() { load_nvm; $cmd \$@ }"
    done
fi
