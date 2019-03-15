"""""""""""
" PLUGINS "
"""""""""""

call plug#begin(stdpath('config') . '/bundle')

" Syntax Checking
Plug 'benekastah/neomake'

" Better Terminals
Plug 'kassio/neoterm'

" EasyAlign
Plug 'junegunn/vim-easy-align'

" Git integration
Plug 'tpope/vim-fugitive'

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

" (NeoVim + tmux) status line
Plug 'bling/vim-airline' | Plug 'edkolev/tmuxline.vim' | Plug 'vim-airline/vim-airline-themes'

" Auto-Completion (Deoplete)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'junegunn/fzf', { 'dir': '~/Applications/fzf', 'do': './install --all' }

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

" NERDTree
Plug 'scrooloose/nerdtree'

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
Plug 'AndrewRadev/splitjoin.vim'

" Rainbow parenthesis
Plug 'junegunn/rainbow_parentheses.vim'

" Easymotion
Plug 'easymotion/vim-easymotion'

" Better folding
Plug 'Konfekt/FastFold'

" Measure startup time
Plug 'tweekmonster/startuptime.vim'

call plug#end()

""""""""""""""""
" VIM SETTINGS "
""""""""""""""""

" Enable filetype plugins, but disable automatic indenting
filetype plugin on
filetype indent off

" Enable syntax highlighting
syntax on

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

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

augroup style
    autocmd!

    " Use 2-space wide indents in languages where it is convention
    autocmd FileType lisp,clojure,haskell,yaml,dart
        \ setlocal shiftwidth=2 softtabstop=2 tabstop=2

    " Create a filled-in column at 80 columns
    autocmd FileType python setl colorcolumn=80
augroup END

"""""""""""""""""""
" PLUGIN SETTINGS "
"""""""""""""""""""

" Colorscheme (depends on the BASE16_COLORSCHEME environment varibale)
set background=dark
let base16colorspace=256
execute ":colorscheme base16-" . $BASE16_COLORSCHEME

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
let g:deoplete#sources#rust#rust_source_path=$HOME . '/Applications/rust/src'

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

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

augroup rust
    autocmd!

    autocmd FileType rust setlocal nosmartindent
    autocmd BufWritePre *.rs silent! RustFmt
augroup END

augroup haskell
    autocmd!

    " Run tests with <Leader>t, assuming ghci is started in a terminal window
    autocmd FileType haskell \
        nnoremap <Leader>t :T :reload<CR>:T :main<CR>
augroup END

function! SetRainbowParentheses()
    autocmd BufEnter <buffer> RainbowParenthesesToggle
    autocmd BufLeave <buffer> RainbowParenthesesToggle
endfunction

augroup rainbow
    autocmd!

    autocmd FileType rust,python,lisp,clojure,haskell call SetRainbowParentheses()
augroup END

" TODO: Can we use something like mustache? idk
function! ReadTemplate(extension)
    let template_path = stdpath('config') . '/templates/template.' . a:extension

    if filereadable(template_path)
        execute '0read' template_path

        " Delete the last line left in the buffer, which is the empty line that
        " gets added to a new file by vim
        normal Gddggdd
    endif
endfunction

augroup templates
  autocmd!

  " When creating a new file, a template will be read from ~/.config/nvim/templates,
  " with the name format 'skeleton' + the extension of the current file
  autocmd BufNewFile *.* call ReadTemplate(expand('<afile>:e'))
augroup END

""""""""""""
" DEOPLETE "
""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

""""""""""""
" STARTIFY "
""""""""""""

let g:startify_bookmarks = [ { 'C': '~/.config/nvim/init.vim' } ]

""""""""""""""
" LSP CLIENT "
""""""""""""""

set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust'   : ['rustup', 'run', 'nightly', 'rls'],
    \ 'python' : ['python3', '-m', 'pyls'],
    \ 'lua'    : ['lua-lsp'],
    \ 'haskell': ['hie-wrapper'],
\ }

let s:cquery_cache_directory = stdpath('cache') . '/cquery'
let s:cquery_log_file = '/tmp/cq.log'
let s:cquery_server_command = [
    \ 'cquery', 
    \ '--log-file=' . s:cquery_log_file ,
    \ '--init={"cacheDirectory":"' . s:cquery_cache_directory . '"}'
\ ]
let g:LanguageClient_serverCommands['c'] = s:cquery_server_command
let g:LanguageClient_serverCommands['cpp'] = s:cquery_server_command

" Handle LanguageClient/NeoVim seamlessly
function! HandleLanguageClientStarted()
    NeomakeDisableBuffer
    nnoremap <buffer> <F5> :call LanguageClient_contextMenu()<CR>
    nnoremap <buffer> K    :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer> gd   :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer> <F2> :call LanguageClient#textDocument_rename()<CR>
endfunction

function! HandleLanguageClientStopped()
    NeomakeEnableBuffer
    nunmap <buffer> <F5>
    nunmap <buffer> K
    nunmap <buffer> gd
    nunmap <buffer> <F2>
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call HandleLanguageClientStarted()
    autocmd User LanguageClientStopped call HandleLanguageClientStopped()
augroup END

""""""""""""
" NERDTree "
""""""""""""

map <C-n> :NERDTreeToggle<CR>
