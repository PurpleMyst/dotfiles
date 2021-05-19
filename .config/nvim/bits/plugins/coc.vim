
set hidden
set completeopt=noinsert,menuone,noselect,preview
set shortmess+=c
set signcolumn=yes
set updatetime=300

let g:airline#extensions#coc#enabled = 1

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
xmap <silent> <leader>ac  <Plug>(coc-codeaction)

nmap <silent> <leader>qf  <Plug>(coc-fix-current)

xmap <silent> <leader>a  <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a  <Plug>(coc-codeaction-selected)

nmap <silent> <leader>rn <Plug>(coc-rename)
