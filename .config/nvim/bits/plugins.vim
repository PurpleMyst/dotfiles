let g:bundle_directory = stdpath('data') . '/bundle'
call SafeMkdir(g:bundle_directory)

let g:ctags_prefix = g:bundle_directory . '/ctags-install'
call SafeMkdir(g:ctags_prefix)

"""""""""""
" PLUGINS "
"""""""""""

silent! if plug#begin(g:bundle_directory)

" Editor config for working with others
Plug 'editorconfig/editorconfig-vim'

" Syntax Checking
Plug 'benekastah/neomake'

" Better Terminals
Plug 'kassio/neoterm'

" Tagbar
Plug 'universal-ctags/ctags', {
    \'do': { info -> puh#PostUpdateHook(info,
        \[['./autogen.sh'],
         \['./configure', '--prefix', g:ctags_prefix],
         \['make', '--jobs', '8'],
         \['make', 'install']]
    \)}
\}

Plug 'majutsushi/tagbar'

" EasyAlign
Plug 'junegunn/vim-easy-align'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Easy parenthesis
Plug 'tpope/vim-surround'

" Repeating of plugins
Plug 'tpope/vim-repeat'

" Easy commenting
Plug 'tpope/vim-commentary'

" Highlight what you yank/undo
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-highlightedundo'

" More targets
Plug 'wellle/targets.vim'

" Start page
Plug 'mhinz/vim-startify'

" Colorscheme
if isdirectory($BASE16_OUTPUT_DIR)
    call plug#($BASE16_OUTPUT_DIR . '/vim')
else
    Plug 'chriskempson/base16-vim'
endif

" (NeoVim + tmux) status line
Plug 'bling/vim-airline' | Plug 'edkolev/tmuxline.vim' | Plug 'vim-airline/vim-airline-themes'

" Remote plugins
Plug 'roxma/nvim-yarp'

" Snippets
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" Auto-Completion
Plug 'neoclide/coc.nvim', { 'do': 'npx yarn install --frozen-lockfile' }
command! -nargs=1 PlugCoc Plug <args>, { 'do': 'npx yarn install --frozen-lockfile' }

" Auto-Completion plugins
PlugCoc 'neoclide/coc-tsserver'
PlugCoc 'neoclide/coc-sources'
PlugCoc 'neoclide/coc-tslint-plugin'
PlugCoc 'fannheyward/coc-rust-analyzer'
PlugCoc 'neoclide/coc-python'
PlugCoc 'neoclide/coc-json'
PlugCoc 'neoclide/coc-css'

" Snippets
PlugCoc 'neoclide/coc-snippets'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/apps/fzf', 'do': './install --all --no-update-rc' }

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

" NERDTree
Plug 'scrooloose/nerdtree'

" DevIcons
"if !has('wsl')
    "Plug 'ryanoasis/vim-devicons'
"endif

" Syntax plugins
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'cespare/vim-toml'
Plug 'dag/vim2hs', { 'for': 'haskell' }
Plug 'leafgarland/typescript-vim'
Plug 'leafo/moonscript-vim'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-crystal'
Plug 'rust-lang/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'elixir-editors/vim-elixir'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'ziglang/zig.vim'
Plug 'mxw/vim-jsx'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'zah/nim.vim', { 'for': 'nim' }
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'calviken/vim-gdscript3'
Plug 'LnL7/vim-nix'
Plug 'vmchale/dhall-vim'

" Rainbow parenthesis
Plug 'junegunn/rainbow_parentheses.vim'

" Easymotion
Plug 'easymotion/vim-easymotion'

" Better folding
"Plug 'Konfekt/FastFold'

" Measure startup time
Plug 'tweekmonster/startuptime.vim'

" Debugger
function! InstallGDB(info)
    call puh#PostUpdateHook(a:info, [['./install.sh']])
    UpdateRemotePlugins
endfunction

Plug 'sakhnik/nvim-gdb', { 'do': { info -> InstallGDB(info) } }

call plug#end()
endif
