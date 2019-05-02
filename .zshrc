# Path to the oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# ZSH Theme
if [ -f "$ZSH/themes/oxide.zsh-theme" ]; then
    ZSH_THEME="oxide"
else
    ZSH_THEME="random"
fi

# Display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# Oh-My-ZSH plugins to load
plugins=(colored-man-pages)

if [ -x "$(command -v tmux)" ]; then
    plugins+=tmux
fi

if [ -e "$ZSH/custom/plugins/zsh-syntax-highlighting" ]; then
    plugins+=zsh-syntax-highlighting
fi

# Oh-My-ZSH environment
source $ZSH/oh-my-zsh.sh

# ls colors
if [ -f ~/.ls_colors ]; then
    eval $(dircolors -b ~/.ls_colors)
fi

# fzf
safe-source ~/.fzf.zsh
