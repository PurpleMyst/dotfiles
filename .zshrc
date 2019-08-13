safe-source ~/.zshrc.d/oxide.zsh-theme

fpath+=("$HOME/.zshrc.d/autoload")
find ~/.zshrc.d/autoload -type f,l ! -name '*zwc*' | while read -r x; do autoload -Uz "$x"; done

find ~/.zshrc.d/modules -type f,l ! -name '*zwc*' | while read -r x; do source "$x"; done

source ~/.zshrc.d/plugins/load.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
