" This function is used in ftplugin/
function! SetRainbowParentheses()
    augroup rainbow
        autocmd BufEnter <buffer> RainbowParentheses
        autocmd BufLeave <buffer> RainbowParentheses!
    augroup END
endfunction
