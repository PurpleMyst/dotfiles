if [ -d "$NVM_DIR" -a -f "$NVM_DIR/nvm.sh" ]; then
    __NVM_SHIMS=()

    __load_nvm() {
        unset -f "${__NVM_SHIMS[@]}"
        source "$NVM_DIR/nvm.sh"
        unset -f __load_nvm
    }

    __create_nvm_shim() {
        __NVM_SHIMS+=("$1")
        eval "$1() { __load_nvm; \"$1\" \"\$@\" }"
    }

    __create_nvm_shims() {
        if [ -d "$1" ]; then
            find "$1" -maxdepth 3 -type f,l -path '*/bin/*' -exec basename {} \; \
            | sort -u \
            | while read -r name; do __create_nvm_shim "$name"; done
        fi
    }

    __create_nvm_shim nvm

    # for coc.nvim
    [ -x "$(command -v nvim)" ] && __create_nvm_shim nvim

    [ -x "$(command -v phanes)" ] && __create_nvm_shim phanes

    __create_nvm_shims "$NVM_DIR/versions/node/"

    __create_nvm_shims "$HOME/.yarn/bin/"
fi
