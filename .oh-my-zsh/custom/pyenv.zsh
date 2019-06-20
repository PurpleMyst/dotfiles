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
        eval "$1() { load_pyenv; $1 \"\$@\" }"
    }

    if [ -d "$PYENV_ROOT/bin" ]; then
        find "$PYENV_ROOT"/{bin,shims} -type f -executable -exec basename {} \; \
        | sort -u \
        | while read -r name; do __create_pyenv_shim "$name"; done
    fi
fi
