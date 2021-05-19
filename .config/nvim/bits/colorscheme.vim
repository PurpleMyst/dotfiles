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
    else
        colorscheme industry
    endif
endif
