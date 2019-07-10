# Send out a notifaction.
if [ -x "$(command -v notify-send)" ]; then
    alias alert="notify-send -i terminal -t 5 'Alert from Terminal!'"
fi

# Force 256-color tmux
alias tmux="tmux -2"
alias tl="tmux list-sessions"
alias ta="tmux attach -t"

# git
alias gi="git init"
alias ga="git add"
alias gc="git commit"
alias gcam="gc -am"
alias gd="git diff"
alias gst="git status"
alias gp="git push"

# python
alias pi="python3 -m pip install --user"

# Latest clang version
alias clang="clang-7"
alias clang++="clang++-7"
