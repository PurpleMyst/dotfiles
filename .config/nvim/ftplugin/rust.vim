" For whatever reason the rust.vim plugin loves setting smartindent
setlocal nosmartindent

" Automatically format on write
autocmd BufWritePre <buffer> silent! RustFmt

if exists("*SetRainbowParentheses")
    call SetRainbowParentheses()
endif
