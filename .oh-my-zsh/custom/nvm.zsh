if [ -d "$NVM_DIR" ]; then
    __NVM_SHIMS=()

    __load_nvm() {
        unset -f "${__NVM_SHIMS[@]}"
        test -f "$NVM_DIR/nvm.sh" && source "$NVM_DIR/nvm.sh"
        unset -f __load_nvm
    }

    __create_nvm_shim() {
        __NVM_SHIMS+=("$1")
        eval "$1() { __load_nvm; $1 \"\$@\" }"
    }

    __create_nvm_shim nvm

    # for coc.nvim
    __create_nvm_shim nvim

    if [ -d "$NVM_DIR/versions/node" ]; then
        find "$NVM_DIR/versions/node/" -maxdepth 3 -type f,l -path '*/bin/*' -exec basename {} \; \
        | sort -u \
        | while read -r name; do __create_nvm_shim "$name"; done
    fi
fi
