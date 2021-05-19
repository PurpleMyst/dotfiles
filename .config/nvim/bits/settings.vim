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

" Move to start/end of word without switching words
nnoremap <leader>b viwo<Esc>
nnoremap <leader>e viw<Esc>

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

" Wraps text at 80 columns.
set textwidth=79

" Don't wrap code (visually)
set nowrap

" Do not automatically format code
set formatoptions-=t

" Do not automatically add comments when using the normal mode commands o and O
set formatoptions-=o

" Store backup/swap files in dedicated directories
let &backupdir=stdpath('data') . '/backup/'
let &directory=stdpath('data') . '/swap/'
call SafeMkdir(&backupdir)
call SafeMkdir(&directory)

" Allows mouse usage (e.g. the scroll wheel)
set mouse=n

" Keep undo history even after exiting a file
let &undodir=stdpath('data') . '/undo/'
set undofile

" Shows a command's effect as you type it
set inccommand=split

" Which characters to use to fill the statusline
let &fillchars='stl:\ ,stlnc:\   '

" Show the color column specially
highlight ColorColumn ctermfg=NONE cterm=bold

" Enable 24-bit RGB color in the TUI
set termguicolors

" Disable cursor shaping
set guicursor=

