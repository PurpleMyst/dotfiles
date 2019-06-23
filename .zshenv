safe-source() { test -f "$1" && source "$1" }

# version managers
export NVM_DIR="${NVM_DIR:=$HOME/.nvm}"
export PYENV_ROOT="${PYENV_ROOT:=$HOME/.pyenv}"

# PATH environment variable
    # System locations
    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

    # Self-made scripts
    PATH="$HOME/bin:$PATH"

    # Per-user scripts
    PATH="$HOME/.local/bin:$PATH"

    # Cargo
    PATH="$HOME/.cargo/bin:$PATH"

    # LuaRocks
    PATH="$HOME/.luarocks/bin:$PATH"

    # Yarn
    PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

    export PATH

# Applications
    safe-source ~/.ghcup/env

    safe-source ~/.poetry/env

    safe-source ~/.opam/opam-init/init.zsh

    [[ ! $- =~ i ]] && safe-source "$NVM_DIR/nvm.sh"

    test -x "$(command -v sccache)" && export RUSTC_WRAPPER=$(which sccache)

    test -f ~/.weechat-passphrase.txt && export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)

    safe-source /etc/profile.d/devkit-env.sh

    test -n "$VIRTUAL_ENV" && safe-source "$VIRTUAL_ENV/bin/activate"
