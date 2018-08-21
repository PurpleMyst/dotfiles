# Open `weechat` in tmux, or connect to an already running instance.
alias weechat-tmux="tmux attach -t chat || tmux new -s chat weechat"

# Send out a notifaction.
alias alert="notify-send -i terminal -t 5 'Alert from Terminal!'"
