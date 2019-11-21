# We utilize two EXTENDED_GLOB features:
# `^` -> "inverse match"
# `(:t)` -> "basename"
setopt EXTENDED_GLOB

# Load our lazily-defined functions
fpath+=($HOME/.zshrc.d/autoload)
autoload -Uz $HOME/.zshrc.d/autoload/^*zwc*(:t)

# Load our configuration modules
for f ($HOME/.zshrc.d/modules/^*zwc*)
    source $f
unset f

unsetopt EXTENDED_GLOB

# Load our plugins
safe-source $HOME/.zshrc.d/plugins/load.zsh
