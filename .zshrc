# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="awesomepanda"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux zsh-syntax-highlighting colored-man-pages)

# $PATH section.
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

# "Vital" aliases go here, the rest are in $ZSH_CUSTOM.
alias tmux="tmux -2"

# GhcUp
test -f ~/.ghcup/env && source ~/.ghcup/env

# fzf
test -f ~/.fzf.zsh  && source ~/.fzf.zsh

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# weechat secure passphrase
test -f ~/.weechat-passphrase.txt && export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)

# ls colors
test -f ~/.ls_colors && eval $(dircolors -b ~/.ls_colors)
