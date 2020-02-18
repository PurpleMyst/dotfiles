augroup autoload
    autocmd!

    autocmd BufWritePost .xbindkeysrc echo system("xbindkeys --poll-rc")
augroup END
