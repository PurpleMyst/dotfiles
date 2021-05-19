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
