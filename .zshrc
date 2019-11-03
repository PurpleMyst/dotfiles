# Load our theme
safe-source "$HOME/.zshrc.d/oxide.zsh-theme"

# Load our lazily-defined functions
fpath+=("$HOME/.zshrc.d/autoload")
fd -E '*zwc*' . "$HOME/.zshrc.d/autoload" \
| while IFS= read -r fun; do autoload -Uz "$fun"; done
unset fun

# Load our configuration modules
fd -E '*zwc*' . "$HOME/.zshrc.d/modules" \
| while IFS= read -r mod; do source "$mod"; done
unset mod

# Load our plugins
safe-source "$HOME/.zshrc.d/plugins/load.zsh"
