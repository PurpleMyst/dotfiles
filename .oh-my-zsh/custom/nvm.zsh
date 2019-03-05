export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ]; then
    NODE_GLOBALS=(`find $NVM_DIR/versions/node/ -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
    NODE_GLOBALS+=("node")
    NODE_GLOBALS+=("nvm")

    load_nvm() {
        unset -f $NODE_GLOBALS
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    }

    for cmd in "${NODE_GLOBALS[@]}"; do
        eval "$cmd() { load_nvm; $cmd \$@ }"
    done
fi
