(
    autoload -U zrecompile

    # Compile the compilation dump
    zrecompile -pq $HOME/.zcompdump

    # Compile zshenv
    zrecompile -pq $HOME/.zshenv

    # Compile zshrc
    zrecompile -pq $HOME/.zshrc

    # Compile all autoloaded functions and configuration modules
    # We utilize two EXTENDED_GLOB features:
    # `^` -> "inverse match"
    # `(.)` -> "only files"
    setopt EXTENDED_GLOB
    zrecompile -pq $HOME/.zshrc.d/{autoload,modules}/^*zwc*(.)
    unsetopt EXTENDED_GLOB

    # Compile the plugin load script
    zrecompile -pq $HOME/.zshrc.d/plugins/load.zsh
) &!
