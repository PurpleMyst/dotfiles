let g:python3_host_prog="/usr/bin/python3"
set pyxversion=3

"""""""""""
" PLUGINS "
"""""""""""

call plug#begin(stdpath('config') . '/bundle')

" Editor config for working with others
Plug 'editorconfig/editorconfig-vim'

" Syntax Checking
Plug 'benekastah/neomake'

" Better Terminals
Plug 'kassio/neoterm'

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

" Highlight what you yank
Plug 'machakann/vim-highlightedyank'

" More targets
Plug 'wellle/targets.vim'

" Start page
Plug 'mhinz/vim-startify'

" Colorscheme
Plug 'chriskempson/base16-vim'

" Transparent background
Plug 'miyakogi/seiya.vim'

" (NeoVim + tmux) status line
Plug 'bling/vim-airline' | Plug 'edkolev/tmuxline.vim' | Plug 'vim-airline/vim-airline-themes'

" Remote plugins
Plug 'roxma/nvim-yarp'

" Snippets
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" Auto-Completion
Plug 'neoclide/coc.nvim', { 'do': 'zsh install.sh nightly' }
Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tslint-plugin', { 'do': 'yarn install --frozen-lockfile' }

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/applications/fzf', 'do': './install --all' }

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

" NERDTree
Plug 'scrooloose/nerdtree'

" Real colors
" Plug 'RRethy/vim-hexokinase'

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

" Rainbow parenthesis
Plug 'junegunn/rainbow_parentheses.vim'

" Easymotion
Plug 'easymotion/vim-easymotion'

" Better folding
"Plug 'Konfekt/FastFold'

" Measure startup time
Plug 'tweekmonster/startuptime.vim'

" Debugger
function! InstallGdb(info)
    echo system("./install.sh")
    UpdateRemotePlugins
endfunction

Plug 'sakhnik/nvim-gdb', { 'do': function('InstallGdb') }

call plug#end()

""""""""""""""""
" VIM SETTINGS "
""""""""""""""""

" Enable filetype plugins, but disable automatic indenting
filetype plugin on
filetype indent off

" Enable syntax highlighting
syntax on

" Don't redraw during macros
set lazyredraw

" Enable syntax folding (<3 FastFold)
set foldmethod=syntax

" Key used for custom commands
let mapleader = ' '

" This is really useful when starting out with Vim to build up your muscle
" memory
" It's useless after you get it ingrained, but I like keeping it in here as a
" testament of vim-fu
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Re-highlight the same area after indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" Underline search results
set hlsearch
highlight Search cterm=underline ctermfg=NONE ctermbg=NONE

" Turn on relative line numbers
set number
set relativenumber

" Shows some characters specially, mostly tabs and trailing spaces
set listchars=tab:>-,trail:·,extends:>,precedes:<
set list
highlight SpecialKey cterm=bold ctermfg=NONE ctermbg=NONE

" Removes the annoying 'Do you want to read this file again?' prompt when
" running an external command
set autoread

" Removes the really annoying 'smart' indent
set nosmartindent

" Expand tabs into 4 spaces
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Wraps text at 80 columns. This gets disabled automatically when writing
" source code, but still wraps comments. Even this one!
set tw=79
set nowrap
set fo-=t

" Store backup/swap files in dedicated directories
let &backupdir=stdpath('config') . '/backup/'
let &directory=stdpath('config') . '/swap/'

" Allows mouse usage (e.g. the scroll wheel)
set mouse=a

" Keep undo history even after exiting a file
let &undodir=stdpath('config') . '/undo/'
set undofile

" Shows a command's effect as you type it
set inccommand=split

" Which characters to use to fill the statusline
set fillchars+=stl:\ ,stlnc:\   

" Show the color column specially
highlight ColorColumn ctermfg=NONE cterm=bold

if $TERM !~ "rxvt"
    set termguicolors
endif

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

augroup completion
    autocmd InsertLeave * pclose
augroup END

augroup style
    autocmd!

    " Use 2-space wide indents in languages where it is convention
    autocmd FileType lisp,clojure,haskell,yaml,dart,javascript.jsx,typescript,json
        \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

    " Create a filled-in column at 88 columns
    autocmd FileType python setl colorcolumn=88
augroup END

augroup rust
    autocmd!

    autocmd FileType rust setlocal nosmartindent
    autocmd BufWritePre *.rs silent! RustFmt
augroup END

function! s:mtime(filename)
    return system('stat -c %Y ' . shellescape(a:filename))
endfunction

function! s:HandleSwapExists()
    if s:mtime(v:swapname) > s:mtime(expand("<afile>"))
        let v:swapchoice='r'
        echom 'Restored ' . expand("<afile>") . ' from swap file'
    else
        let v:swapchoice='d'
        echom 'Deleted swap file for ' . expand("<afile>")
    endif
endfunction

augroup swapexists
    autocmd!

    autocmd SwapExists * call s:HandleSwapExists()
augroup END

"""""""""""""""
" COLORSCHEME "
"""""""""""""""

set background=dark
let base16colorspace=256
execute ":colorscheme base16-" . $BASE16_COLORSCHEME

"""""""""""""
" GUICURSOR "
"""""""""""""

set guicursor=

"""""""""""""""""""
" PLUGIN SETTINGS "
"""""""""""""""""""

"""""""""""
" NEOMAKE "
"""""""""""

" Automatic syntax checking
call neomake#configure#automake({
\ 'TextChanged':  {},
\ 'TextChangedI': {},
\ 'InsertLeave':  {},
\ 'BufWritePost': {'delay': 0},
\ 'BufReadPost':  {},
\ }, 500)

let g:neomake_cpp_clang_args = ['-std=c++17', '-Wall', '-Wextra', '-Weffc++']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']
let g:neomake_c_clang_args = ['-std=c99', '-Wall', '-Wextra', '-Weffc++']
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.6/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_sh_shellcheck_args = ['-fgcc']

let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path=$HOME . '/applications/rust/src'

"""""""""""
" NEOTERM "
"""""""""""

" Have <Esc> work like it does in every other mode in terminal mode
tnoremap <Esc> <C-\><C-n>

" Have terminals be in the bottom right by default
let g:neoterm_default_mod = 'botright'

""""""""
" PLUG "
""""""""

let g:plug_window = 'enew'

""""""""""""""""""""
" AIRLINE/TMUXLINE "
""""""""""""""""""""

let g:airline_powerline_fonts = 0
let g:tmuxline_powerline_separators = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = 'iceberg'
let g:tmuxline_preset = 'tmux'

"let g:airline_section_a = airline#section#create([])
"let g:airline_section_b = airline#section#create([])
"let g:airline_section_c = airline#section#create([])
"let g:airline_section_x = airline#section#create([])
"let g:airline_section_y = airline#section#create([])
"let g:airline_section_z = airline#section#create([])

"""""""""""""""""""""""
" RAINBOW PARENTHESES "
"""""""""""""""""""""""

function! SetRainbowParentheses()
    autocmd BufEnter <buffer> RainbowParentheses
    autocmd BufLeave <buffer> RainbowParentheses!
endfunction

augroup rainbow
    autocmd!

    autocmd FileType rust,python,lisp,clojure,haskell call SetRainbowParentheses()
augroup END

""""""""""""
" STARTIFY "
""""""""""""

let g:startify_custom_header = 'map(startify#fortune#boxed(), ''"  " . v:val'')'

let g:startify_lists = [
    \ { 'type': 'dir',       'header': ['   Directory'] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
    \ { 'type': 'commands',  'header': ['   Commands'] },
\ ]

let g:startify_use_env = 1

let g:startify_bookmarks = [
    \ { 'C': '~/.config/nvim/init.vim' },
    \ { 'Z': '~/.zshrc' },
\ ]

let g:startify_commands = [
    \ { 'up' : ['Update plugins', 'PlugUpdate'] },
    \ { 'uP' : ['Update plugin manager', 'PlugUpgrade'] },
\ ]

"""""""
" FZF "
"""""""

nnoremap <leader>f :FZF<CR>

"""""""
" COC "
"""""""

set hidden
set completeopt=noinsert,menuone,noselect,preview
set shortmess+=c
set signcolumn=yes
set updatetime=300

let g:airline#extensions#coc#enabled = 1
let g:airline_section_y = airline#section#create(['%{coc#status()}'])

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
    if &filetype == 'vim' || &filetype == 'help'
        execute 'help' expand('<cword>')
    elseif &filetype == 'sh' || &filetype == 'zsh'
        execute 'Man' expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

augroup coc
    autocmd!

    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceHolder call CocActionAsync('showSignatureHelp')
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>rn <Plug>(coc-rename)

""""""""""""
" NERDTree "
""""""""""""

map <C-n> :NERDTreeToggle<CR>

""""""""""""""
" HEXOKINASE "
""""""""""""""

" if &termguicolors
"     let g:Hexokinase_ftAutoload = ["css", "javascript.jsx", "xdefaults"]
" endif

"""""""""""
" NVIMGDB "
"""""""""""

" We're going to define single-letter keymaps, so don't try to define them
" in the terminal window.  The debugger CLI should continue accepting text commands.
function! NvimGdbNoTKeymaps()
endfunction

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': '',
  \ }

"""""""""
" SEIYA "
"""""""""

let g:seiya_auto_enable=exists('$TMUX')
let g:seiya_target_groups = &termguicolors ? ['guibg'] : ['ctermbg']
