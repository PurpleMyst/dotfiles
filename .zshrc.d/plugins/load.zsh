PLUGINS=$(dirname "$0")

# Load regular plugins
safe-source "$PLUGINS/zsh-colored-man-pages/colored-man-pages.plugin.zsh"
safe-source "$PLUGINS/fzf.zsh"

# Load completions after regular plugins
autoload -Uz compinit
# Here we use two extended glob qualifiers to check:
# N     -> If the glob does not match any file, do not output an error to
#          stderr, just substitute the empty string
# mh-24 -> Match files which were modified within the last 24 hours
setopt EXTENDED_GLOB
if [[ $HOME/.zcompdump(#qNmh-24) ]]; then
    # If the glob returns a non-empty string, we know zcompdump is fresh and we
    # can tell compinit to not rebuild it
    compinit -C
else
    # If the glob returned an empty string, zcompdump is either stale or not
    # present and we must rebuild it
    compinit
fi
unsetopt EXTENDED_GLOB

# Load syntax highlighting plugin after completions
safe-source "$PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load the prompt
fpath+=("$PLUGINS/pure")
autoload -Uz promptinit; promptinit
prompt pure

unset PLUGINS
