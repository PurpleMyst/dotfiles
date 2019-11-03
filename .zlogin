(
    autoload -U zrecompile

    # Compile the compilation dump
    zrecompile -pq "$HOME/.zcompdump"

    # Compile zshenv
    zrecompile -pq "$HOME/.zshenv"

    # Compile zshrc
    zrecompile -pq "$HOME/.zshrc"

    # Compile all autoloaded functions and configuration modules
    local file
    fd -E '*.zwc' --type file . $HOME/.zshrc.d/{autoload,modules} \
    | while IFS= read -r file; do zrecompile -pq "$file"; done

    # Compile the plugin load script
    zrecompile -pq "$HOME/.zshrc.d/plugins/load.zsh"
) &!
