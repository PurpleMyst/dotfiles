# Send out a notifaction.
if which notify-send > /dev/null; then
    alias alert="notify-send -i terminal -t 5 'Alert from Terminal!'"
fi

# Latest clang version
alias clang="clang-7"
alias clang++="clang++-7"
