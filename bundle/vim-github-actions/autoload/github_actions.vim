function! github_actions#setup_buffer() abort
    if !get(b:, 'github_actions_workflow', 0)
        return
    endif

    if exists('b:github_actions_setup_done')
        return
    endif
    let b:github_actions_setup_done = 1

    command! -buffer GitHubActionsSyntaxRefresh call github_actions#force_refresh_syntax()

    augroup github_actions_buffer
        autocmd! * <buffer>
        autocmd BufWinEnter <buffer> call github_actions#force_refresh_syntax()
        autocmd BufEnter,BufWritePost,TextChanged,TextChangedI <buffer> call github_actions#refresh_syntax()
    augroup END
endfunction

function! github_actions#force_refresh_syntax() abort
    unlet! b:github_actions_embedded_syntax_loaded
    call github_actions#refresh_syntax()
endfunction

function! github_actions#refresh_syntax() abort
    if !get(b:, 'github_actions_workflow', 0)
        return
    endif

    if get(b:, 'current_syntax', '') !=# 'yaml'
        return
    endif

    call github_actions#ensure_embedded_syntax()

    if exists('b:github_actions_dynamic_groups') && !empty(b:github_actions_dynamic_groups)
        execute 'silent! syntax clear ' . join(b:github_actions_dynamic_groups)
    endif

    let b:github_actions_dynamic_groups = []

    let lnum = 1
    while lnum <= line('$')
        if getline(lnum) =~# '^\s*\%(-\s*\)\?run:\s*[|>].*$'
            let body_start = github_actions#find_block_start(lnum)
            let body_end = github_actions#find_block_end(lnum)
            if body_start > 0 && body_end >= body_start
                let group = 'githubActionsRun_' . lnum
                let cluster = github_actions#shell_cluster(lnum)
                let cmd = printf(
                            \ 'syntax region %s start=/\%%%dl^\s*\%(-\s*\)\?run:\s*[|>].*$/ end=/\%%%dl$/ contains=%s keepend transparent',
                            \ group,
                            \ lnum,
                            \ body_end,
                            \ cluster
                            \ )
                execute cmd
                call add(b:github_actions_dynamic_groups, group)
            endif
            let lnum = max([lnum + 1, body_end + 1])
            continue
        endif
        let lnum += 1
    endwhile
endfunction

function! github_actions#ensure_embedded_syntax() abort
    if exists('b:github_actions_embedded_syntax_loaded')
        return
    endif

    let current_syntax = get(b:, 'current_syntax', '')

    unlet! b:current_syntax
    if !exists(':ShFoldFunctions')
        command! -nargs=* ShFoldFunctions
    endif
    if !exists(':ShFoldHereDoc')
        command! -nargs=* ShFoldHereDoc
    endif
    if !exists(':ShFoldIfDoFor')
        command! -nargs=* ShFoldIfDoFor
    endif
    syntax include @GitHubActionsBash syntax/sh.vim

    unlet! b:current_syntax
    syntax include @GitHubActionsPython syntax/python.vim

    let b:current_syntax = empty(current_syntax) ? 'yaml' : current_syntax
    let b:github_actions_embedded_syntax_loaded = 1
endfunction

function! github_actions#find_block_start(run_lnum) abort
    let lnum = a:run_lnum + 1
    while lnum <= line('$')
        if getline(lnum) =~# '^\s*$'
            let lnum += 1
            continue
        endif
        if indent(lnum) > indent(a:run_lnum)
            return lnum
        endif
        return 0
    endwhile
    return 0
endfunction

function! github_actions#find_block_end(run_lnum) abort
    let body_start = github_actions#find_block_start(a:run_lnum)
    if body_start == 0
        return 0
    endif

    let lnum = body_start + 1
    while lnum <= line('$')
        if getline(lnum) =~# '^\s*$'
            let lnum += 1
            continue
        endif
        if indent(lnum) <= indent(a:run_lnum)
            return lnum - 1
        endif
        let lnum += 1
    endwhile

    return line('$')
endfunction

function! github_actions#shell_cluster(run_lnum) abort
    let step_root = github_actions#step_root(a:run_lnum)
    for lnum in range(step_root, a:run_lnum - 1)
        let line = getline(lnum)
        if line =~# '^\s*\%(-\s*\)\?shell:\s*python\%([23]\)\?\>'
            return '@GitHubActionsPython'
        endif
        if line =~# '^\s*\%(-\s*\)\?shell:\s*\%(bash\|sh\)\>'
            return '@GitHubActionsBash'
        endif
    endfor
    return '@GitHubActionsBash'
endfunction

function! github_actions#step_root(run_lnum) abort
    if getline(a:run_lnum) =~# '^\s*-\s*run:\s*[|>].*$'
        return a:run_lnum
    endif

    let run_indent = indent(a:run_lnum)
    let lnum = a:run_lnum - 1
    while lnum >= 1
        let line = getline(lnum)
        if line =~# '^\s*-\s' && indent(lnum) < run_indent
            return lnum
        endif
        if indent(lnum) < run_indent && line !~# '^\s*$'
            break
        endif
        let lnum -= 1
    endwhile

    return a:run_lnum
endfunction
