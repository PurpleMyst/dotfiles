" Unset options that are set by rust.vim but which I do not like
setlocal nosmartindent
setlocal formatoptions-=o

" Automatically format on write if the buffer has been changed
if exists(":RustFmt")
    autocmd BufWritePre <buffer> if &modified | call rustfmt#Format() | endif
endif

if exists("*SetRainbowParentheses")
    call SetRainbowParentheses()
endif
