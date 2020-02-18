augroup dash_ftdetect
    autocmd!

    autocmd BufRead,BufNewFile * if getline(1) == "#!/usr/bin/env dash" | setfiletype sh | endif
augroup END
