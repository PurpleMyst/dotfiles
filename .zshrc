# Path to the oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
ZSH_THEME="oxide"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Command execution time stamp format
HIST_STAMPS="dd/mm/yyyy"

# oh-my-zsh plugins
plugins=(tmux zsh-syntax-highlighting colored-man-pages)

    # System locations
    export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:"

    # Self-made scripts
    export PATH="$HOME/bin:$PATH"

    # User-only scripts intalled by things like pip.
    export PATH="$HOME/.local/bin:$PATH"

    # Cargo binaries.
    export PATH="$HOME/.cargo/bin:$PATH"

# Oh My ZSH Config.
source $ZSH/oh-my-zsh.sh

# Preferred applications.
export EDITOR='nvim'
export BROWSER='firefox'
export TERMINAL='urxvt'

function safe-source() {
    test -f $1 && source $1
}

# GhcUp
safe-source ~/.ghcup/env

# poetry
safe-source ~/.poetry/env

# OPAM
safe-source ~/.opam/opam-init/init.zsh

# fzf
safe-source ~/.fzf.zsh

# sccache
which sccache > /dev/null && export RUSTC_WRAPPER=$(which sccache)

# weechat secure passphrase
test -f ~/.weechat-passphrase.txt && export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)

# ls colors
test -f ~/.ls_colors && eval $(dircolors -b ~/.ls_colors)
