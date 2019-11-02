safe-source() { [ -f "$1" ] && source "$1" }

#########
# $PATH #
#########
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

PATH="$HOME/bin:$PATH"

PATH="$HOME/.local/bin:$PATH"

PATH="$HOME/.cargo/bin:$PATH"

PATH="$HOME/.luarocks/bin:$PATH"

PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

PATH="$HOME/.nimble/bin:$PATH"

safe-source ~/.ghcup/env

safe-source ~/.nix-profile/etc/profile.d/nix.sh

safe-source ~/.poetry/env

safe-source /etc/profile.d/devkit-env.sh

export PATH

###########
# sccache #
###########
[ -x "$(command -v sccache)" ] && export RUSTC_WRAPPER=$(which sccache)

###########
# weechat #
###########
[ -f ~/.weechat-passphrase.txt ] && export WEECHAT_PASSPHRASE=$(cat ~/.weechat-passphrase.txt)

########
# venv #
########
[ -n "$VIRTUAL_ENV" ] && safe-source "$VIRTUAL_ENV/bin/activate"

#################
# compinit skip #
#################
skip_global_compinit=1
