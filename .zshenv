function safe-source() {
    test -f $1 && source $1
}

# $PATH
    # System locations
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:"

    # Self-made scripts
    export PATH="$HOME/bin:$PATH"

    # Per-user scripts
    export PATH="$HOME/.local/bin:$PATH"

    # Cargo
    export PATH="$HOME/.cargo/bin:$PATH"

    # GhcUp
    safe-source ~/.ghcup/env

    # poetry
    safe-source ~/.poetry/env

    # OPAM
    safe-source ~/.opam/opam-init/init.zsh

    # fzf
    safe-source ~/.fzf.zsh

# sccache
if [ -x "$(command -v sccache)" ]; then
    export RUSTC_WRAPPER=$(which sccache)
fi

# weechat
if [ -f ~/.weechat-passphrase.txt ]; then
    export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)
fi
