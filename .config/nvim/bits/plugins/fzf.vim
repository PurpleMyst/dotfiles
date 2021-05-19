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
