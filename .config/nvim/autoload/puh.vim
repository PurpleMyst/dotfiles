function! puh#PostUpdateHook(info, cmds)
    if a:info.status ==# 'unchanged' && !a:info.force
        return
    endif

    let l:buf = nvim_create_buf(v:false, v:true)

    let l:width = float2nr(&columns - 20)
    let l:height = float2nr(40)
    let l:col = float2nr((&columns - l:width) / 2)
    let l:row = float2nr((&lines - l:height) / 2)

    let l:window = nvim_open_win(buf, v:true, {
        \'relative': 'editor',
        \'row': l:row,
        \'col': l:col,
        \'width': l:width,
        \'height': l:height,
        \'style': 'minimal'
    \})

    let l:chunk = ''
    function! s:HandleJobOutput(job_id, data, event) closure
        " Prepend the stored line chunk to the first line
        let a:data[0] = l:chunk . a:data[0]

        " The last line is incomplete, so store it as a chunk
        let l:chunk = remove(a:data, -1)

        " Append the complete lines to the buffer and scroll
        if !empty(a:data)
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, a:data)
            call nvim_win_set_cursor(l:window, [nvim_buf_line_count(l:buf), 0])
            redraw!
        endif
    endfunction

    " We utilize this variable to make it so the first line isn't empty
    let l:start = 0
    for l:cmd in a:cmds
        if type(l:cmd) == v:t_string
            call nvim_buf_set_lines(l:buf, l:start, -1, v:false, ['$ ' . l:cmd])
        elseif type(l:cmd) == v:t_list
            call nvim_buf_set_lines(l:buf, l:start, -1, v:false, ['$ ' . join(map(copy(l:cmd), { _, v -> shellescape(v) }), ' ')])
        endif
        let l:start = -1

        let l:job = jobstart(l:cmd, {
            \'on_stdout': funcref('s:HandleJobOutput'),
            \'on_stderr': funcref('s:HandleJobOutput'),
        \})

        let l:status = jobwait([l:job])[0]
        if l:status == 0
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, ['[ exited with 0 ]'])
        elseif l:status == -2
            throw 'Job ' . string(l:job) . ' was interrupted'
        else
            call nvim_buf_set_lines(l:buf, -1, -1, v:false, ['[ exited with ' . string(l:status) . ' ]'])
            throw 'Job ' . string(l:job) . ' exited with status ' . string(l:status)
        endif
    endfor

    call nvim_win_close(l:window, v:false)
endfunction
