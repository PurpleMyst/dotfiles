scriptencoding utf-8

let g:python3_host_prog='/usr/bin/python3'
set pyxversion=3

let SafeMkdir = { name -> isdirectory(name) ? 0 : mkdir(name) }

execute "source" stdpath('config') . '/bits/plugins.vim'
execute "source" stdpath('config') . '/bits/settings.vim'
execute "source" stdpath('config') . '/bits/autocommands.vim'
execute "source" stdpath('config') . '/bits/colorscheme.vim'

execute "source" stdpath('config') . '/bits/plugins/neomake.vim'
execute "source" stdpath('config') . '/bits/plugins/neoterm.vim'
execute "source" stdpath('config') . '/bits/plugins/plug.vim'
execute "source" stdpath('config') . '/bits/plugins/airtmuxline.vim'
execute "source" stdpath('config') . '/bits/plugins/rainbowparentheses.vim'
execute "source" stdpath('config') . '/bits/plugins/startify.vim'
execute "source" stdpath('config') . '/bits/plugins/fzf.vim'
execute "source" stdpath('config') . '/bits/plugins/coc.vim'
execute "source" stdpath('config') . '/bits/plugins/nerdtree.vim'
execute "source" stdpath('config') . '/bits/plugins/nvimgdb.vim'
execute "source" stdpath('config') . '/bits/plugins/tagbar.vim'
