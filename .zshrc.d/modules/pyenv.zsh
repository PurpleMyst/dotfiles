if [ -d "$PYENV_ROOT" ]; then
    __PYENV_SHIMS=()

    __load_pyenv() {
        unset -f "${__PYENV_SHIMS[@]}"

        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }

    __create_pyenv_shim() {
        __PYENV_SHIMS+=("$1")
        eval "$1() { __load_pyenv; "$1" \"\$@\" }"
    }

    __create_pyenv_shims() {
        if [ -d "$1" ]; then
            find "$1" -type f,l -executable -exec basename {} \; \
            | sort -u \
            | while read -r name; do __create_pyenv_shim "$name"; done
        fi
    }

    __create_pyenv_shims "$PYENV_ROOT/bin"
    __create_pyenv_shims "$PYENV_ROOT/shims"
fi
