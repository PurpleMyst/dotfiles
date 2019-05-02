export PYENV_ROOT="${PYENV_ROOT:=$HOME/.pyenv}"

if [ -d "$PYENV_ROOT" ]; then
    PYENV_GLOBALS=()

    PYENV_GLOBALS_FULLPATH=$(find "$PYENV_ROOT/bin" "$PYENV_ROOT/shims" -type f -executable)
    if [ -n "$PYENV_GLOBALS_FULLPATH" ]; then
        PYENV_GLOBALS+=($(echo "$PYENV_GLOBALS_FULLPATH" | xargs -n1 basename | sort -u))
    fi

    load_pyenv() {
        unset -f $PYENV_GLOBALS
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }

    for cmd in "${PYENV_GLOBALS[@]}"; do
        eval "$cmd() { load_pyenv; $cmd \$@ }"
    done
fi
