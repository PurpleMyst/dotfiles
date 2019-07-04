safe-source() { [ -f "$1" ] && source "$1" }

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

# Other environment variables
    [ -x "$(command -v sccache)" ] && export RUSTC_WRAPPER=$(which sccache)

    [ -f ~/.weechat-passphrase.txt ] && export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)

    [ -d "$HOME/.nvm" ] && export NVM_DIR="$HOME/.nvm"
    [ -d "$HOME/.pyenv" ] && export PYENV_ROOT="$HOME/.pyenv"

# Applications
    safe-source ~/.ghcup/env

    safe-source ~/.poetry/env

    safe-source /etc/profile.d/devkit-env.sh


# Lazy loaded environments
    if [[ ! $- =~ i ]]; then  
        if [ -n "$NVM_DIR" ]; then
            safe-source "$NVM_DIR/nvm.sh"
        fi

        if [ -n "$PYENV_ROOT" ]; then
            export PATH="$PYENV_ROOT/bin:$PATH"
            eval "$(pyenv init -)"
            eval "$(pyenv virtualenv-init -)"
        fi
    fi


# Venv fix
    [ -n "$VIRTUAL_ENV" ] && safe-source "$VIRTUAL_ENV/bin/activate"

# skip global compinit cause we do it later
    skip_global_compinit=1
