augroup autoload_ftdetect
    autocmd!

    " Detect autoload functions which do not use the .zsh suffix
    autocmd BufRead,BufNewFile ~/.zshrc.d/autoload/* setfiletype zsh
augroup END
