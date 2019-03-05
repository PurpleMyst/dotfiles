export PYENV_ROOT="${PYENV_ROOT:=$HOME/.pyenv}"

if [ -d "$PYENV_ROOT" ]; then
    PYENV_GLOBALS=(`ls "$PYENV_ROOT/bin"`)
    PYENV_GLOBALS+=(`ls "$PYENV_ROOT/shims"`)

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
