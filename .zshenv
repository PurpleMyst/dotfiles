safe-source() { [ -f "$1" ] && source "$1" }

#########
# $PATH #
#########
path=(/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin)

path=($HOME/bin $path)

path=($HOME/.local/bin $path)

path=($HOME/.cargo/bin $path)

path=($HOME/.luarocks/bin $path)

path=($HOME/.yarn/bin $home/.config/yarn/global/node_modules/.bin $path)

path=($HOME/.nimble/bin $path)

safe-source ~/.ghcup/env

safe-source ~/.nix-profile/etc/profile.d/nix.sh

safe-source ~/.poetry/env

safe-source /etc/profile.d/devkit-env.sh

export PATH

###########
# sccache #
###########
export RUSTC_WRAPPER=${commands[sccache]}

###########
# weechat #
###########
if [[ -f ~/.weechat-passphrase.txt ]] export WEECHAT_PASSPHRASE=$(<~/.weechat-passphrase.txt)

########
# venv #
########
if [[ -n $VIRTUAL_ENV ]] safe-source $VIRTUAL_ENV/bin/activate

#################
# compinit skip #
#################
skip_global_compinit=1
