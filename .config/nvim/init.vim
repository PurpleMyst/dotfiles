scriptencoding utf-8

let g:python3_host_prog='/usr/bin/python3'
set pyxversion=3

let SafeMkdir = { name -> isdirectory(name) ? 0 : mkdir(name) }

""""""""""""""""""
" PLUGIN HELPERS "
""""""""""""""""""

let g:bundle_directory = stdpath('config') . '/bundle'
call SafeMkdir(g:bundle_directory)

let g:ctags_prefix = g:bundle_directory . '/ctags-install'
call SafeMkdir(g:ctags_prefix)

function! PostUpdateHook(info, cmds)
    if a:info.status ==# 'unchanged' && !a:info.force
        return
    endif

    let l:buf = nvim_create_buf(v:false, v:true)

    let l:width = float2nr(&columns - 20)
    let l:height = float2nr(40)
    let l:col = float2nr((&columns - l:width) / 2)
    let l:row = float2nr((&lines - l:height) / 2)

    let l:window = nvim_open_win(buf, v:true, {
        \'relative': 'editor',
        \'row': l:row,
        \'col': l:col,
        \'width': l:width,
        \'height': l:height,
        \'style': 'minimal'
    \})

    let l:chunk = ''
    function! s:HandleJobOutput(job_id, data, event) closure
        " Prepend the stored line chunk to the first line
        let a:data[0] = l:chunk . a:data[0]

        " The last line is incomplete, so store it as a chunk
        let l:chunk = remove(a:data, -1)

        " Append the complete lines to the buffer and scroll
        if !empty(a:data)
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, a:data)
            call nvim_win_set_cursor(l:window, [nvim_buf_line_count(l:buf), 0])
            redraw!
        endif
    endfunction

    " We utilize this variable to make it so the first line isn't empty
    let l:start = 0
    for l:cmd in a:cmds
        if type(l:cmd) == v:t_string
            call nvim_buf_set_lines(l:buf, l:start, -1, v:false, ['$ ' . l:cmd])
        elseif type(l:cmd) == v:t_list
            call nvim_buf_set_lines(l:buf, l:start, -1, v:false, ['$ ' . join(map(copy(l:cmd), { _, v -> shellescape(v) }), ' ')])
        endif
        let l:start = -1

        let l:job = jobstart(l:cmd, {
            \'on_stdout': funcref('s:HandleJobOutput'),
            \'on_stderr': funcref('s:HandleJobOutput'),
        \})

        let l:status = jobwait([l:job])[0]
        if l:status == 0
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, ['[ exited with 0 ]'])
        elseif l:status == -2
            throw 'Job ' . string(l:job) . ' was interrupted'
        else
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, ['[ exited with ' . string(l:status) . ' ]'])
            throw 'Job ' . string(l:job) . ' exited with status ' . string(l:status)
        endif
    endfor

    call nvim_win_close(l:window, v:false)
endfunction

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
    \'do': { info -> PostUpdateHook(info,
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

" Highlight what you yank
Plug 'machakann/vim-highlightedyank'

" More targets
Plug 'wellle/targets.vim'

" Start page
Plug 'mhinz/vim-startify'

" Colorscheme
if empty($BASE16_OUTPUT_DIR)
    Plug 'chriskempson/base16-vim'
else
    call plug#($BASE16_OUTPUT_DIR . '/vim')
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
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
command! -nargs=1 PlugCoc Plug <args>, { 'do': 'yarn install --frozen-lockfile' }

" Auto-Completion plugins
PlugCoc 'neoclide/coc-tsserver'
PlugCoc 'neoclide/coc-sources'
PlugCoc 'neoclide/coc-tslint-plugin'
PlugCoc 'neoclide/coc-rls'
PlugCoc 'neoclide/coc-python'
PlugCoc 'neoclide/coc-json'
PlugCoc 'neoclide/coc-css'
PlugCoc 'amiralies/coc-elixir'

" Snippets
PlugCoc 'neoclide/coc-snippets'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/applications/fzf', 'do': './install --all --no-update-rc' }

" Custom text objects
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'glts/vim-textobj-comment'

" NERDTree
Plug 'scrooloose/nerdtree'

" DevIcons
if !has('wsl') | Plug 'ryanoasis/vim-devicons' | endif

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
    call PostUpdateHook(a:info, [['./install.sh']])
    UpdateRemotePlugins
endfunction

Plug 'sakhnik/nvim-gdb', { 'do': { info -> InstallGDB(info) } }

call plug#end()
endif

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
let &backupdir=stdpath('config') . '/backup/'
let &directory=stdpath('config') . '/swap/'
call SafeMkdir(&backupdir)
call SafeMkdir(&directory)

" Allows mouse usage (e.g. the scroll wheel)
set mouse=n

" Keep undo history even after exiting a file
let &undodir=stdpath('config') . '/undo/'
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

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

augroup completion
    autocmd!

    autocmd InsertLeave * pclose
augroup END

augroup swapexists
    autocmd!

    function! s:mtime(filename)
        return system(['stat', '-c', '%Y', a:filename])
    endfunction

    function! s:HandleSwapExists()
        if s:mtime(v:swapname) > s:mtime(expand('<afile>'))
            let v:swapchoice='r'
            echom 'Restored' expand('<afile>') 'from swap file'
        else
            let v:swapchoice='d'
            echom 'Deleted swap file for' expand('<afile>')
        endif
    endfunction

    autocmd SwapExists * call <SID>HandleSwapExists()
augroup END

"""""""""""""""
" COLORSCHEME "
"""""""""""""""

set background=dark
let base16colorspace=256

if !empty($BASE16_COLORSCHEME)
    execute ':colorscheme base16-' . $BASE16_COLORSCHEME
elseif filereadable($HOME . '/.colorscheme')
    execute ':colorscheme base16-' . readfile($HOME . '/.colorscheme')[0]
else
    " If we don't have a clue which colorscheme to pick, just get a list of all
    " base16 colorschemes and pick one at random.. or as close as we can get to
    " random in VimL
    let s:colors = getcompletion('base16-', 'color')

    if !empty(s:colors)
        execute ':colorscheme' s:colors[localtime() % len(s:colors)]
    endif
endif

"""""""""""""""""""
" PLUGIN SETTINGS "
"""""""""""""""""""

"""""""""""
" NEOMAKE "
"""""""""""

" Automatic syntax checking
if exists('*neomake#configure#automake')
    call neomake#configure#automake({
    \'TextChanged':  {},
    \'TextChangedI': {},
    \'InsertLeave':  {},
    \'BufWritePost': {'delay': 0},
    \'BufReadPost':  {},
    \}, 500)
endif

let g:neomake_cpp_clang_args = ['-std=c++17', '-Wall', '-Wextra', '-Weffc++']
let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']
let g:neomake_c_clang_args = ['-std=c99', '-Wall', '-Wextra', '-Weffc++']

let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_sh_shellcheck_args = ['-fgcc']

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

let g:airline_powerline_fonts = !has('wsl')
let g:tmuxline_powerline_separators = !has('wsl')
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = 'iceberg'
let g:tmuxline_preset = 'tmux'

"""""""""""""""""""""""
" RAINBOW PARENTHESES "
"""""""""""""""""""""""

" This function is used in ftplugin/
function! SetRainbowParentheses()
    autocmd rainbow BufEnter <buffer> RainbowParentheses
    autocmd rainbow BufLeave <buffer> RainbowParentheses!
endfunction

""""""""""""
" STARTIFY "
""""""""""""

let g:startify_custom_header = 'startify#center(startify#fortune#boxed())'

let g:startify_lists = [
    \{ 'type': 'dir',       'header': startify#pad(['Directory']) },
    \{ 'type': 'bookmarks', 'header': startify#pad(['Bookmarks']) },
    \{ 'type': 'commands',  'header': startify#pad(['Commands']) },
\]

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

"""""""
" FZF "
"""""""

let g:fzf_colors = {
    \'gutter': ['bg', 'NormalFloat'],
\}

nnoremap <leader>f :FZF --margin 1<CR>

" FloatingFZF courtesy of https://www.reddit.com/r/neovim/comments/djmehv/-/f463fxr/
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
    let l:buf = nvim_create_buf(v:false, v:true)

    let l:width = float2nr(80)
    let l:height = float2nr(10)
    let l:col = float2nr((&columns - l:width) / 2)
    let l:row = float2nr((&lines - l:height) / 2)

    call nvim_open_win(buf, v:true, {
        \'relative': 'editor',
        \'row': l:row,
        \'col': l:col,
        \'width': l:width,
        \'height': l:height,
        \'style': 'minimal'
    \})

    " Close the buffer if you press <ESC>
    execute 'autocmd TermLeave <buffer=' . l:buf . '> close'
endfunction

"""""""
" COC "
"""""""

set hidden
set completeopt=noinsert,menuone,noselect,preview
set shortmess+=c
set signcolumn=yes
set updatetime=300

let g:airline#extensions#coc#enabled = 1

if exists('*airline#section#create') && exists('*coc#status')
    let g:airline_section_y = airline#section#create(['%{coc#status()}'])
endif

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
    if &filetype ==? 'vim' || &filetype ==? 'help'
        execute 'help' expand('<cword>')
    elseif &filetype ==? 'sh' || &filetype ==? 'zsh'
        execute 'Man' 1 expand('<cword>')
    elseif &filetype ==?'c'
        execute 'Man' 3 expand('<cword>')
    elseif exists('g:coc_status')
        call CocActionAsync('doHover')
    else
        echoerr 'No idea how to get help'
    endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

if exists('*CocAction')
    augroup coc
        autocmd!

        autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
        autocmd User CocJumpPlaceHolder call CocActionAsync('showSignatureHelp')
        autocmd CursorHold * silent call CocActionAsync('highlight')
    augroup END
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader>ac  <Plug>(coc-codeaction)
nmap <silent> <leader>qf  <Plug>(coc-fix-current)

xmap <silent> <leader>a  <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a  <Plug>(coc-codeaction-selected)

nmap <silent> <leader>rn <Plug>(coc-rename)

""""""""""""
" NERDTree "
""""""""""""

noremap <C-n> :NERDTreeToggle<CR>

"""""""""""
" NVIMGDB "
"""""""""""

let g:nvimgdb_config_override = {
    \'key_next': 'n',
    \'key_step': 's',
    \'key_finish': 'f',
    \'key_continue': 'c',
    \'key_until': 'u',
    \'key_breakpoint': 'b',
    \'set_tkeymaps': '',
\}

""""""""""
" TAGBAR "
""""""""""

nnoremap <F8> :Tagbar<CR>
let g:tagbar_ctags_bin = g:ctags_prefix . '/bin/ctags'
