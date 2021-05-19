let g:startify_custom_header = 'startify#center(startify#fortune#boxed())'

if exists('*startify#pad')
let g:startify_lists = [
    \{ 'type': 'dir',       'header': startify#pad(['Directory']) },
    \{ 'type': 'bookmarks', 'header': startify#pad(['Bookmarks']) },
    \{ 'type': 'commands',  'header': startify#pad(['Commands']) },
\]
endif

let g:startify_use_env = 1

let g:startify_bookmarks = [
    \{ 'C': stdpath('config') . '/init.vim' },
    \{ 'Z': '~/.zshrc' },
    \{ 'N': '~/.config/nixpkgs/overlays/lnl.nix' },
\]

let g:startify_commands = [
    \{ 'up' : ['Update plugins', 'PlugUpdate'] },
    \{ 'uP' : ['Update plugin manager', 'PlugUpgrade'] },
\]

let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
