if exists('g:loaded_ticard')
  finish
endif
let g:loaded_ticard = 1

function! s:TicardPush()
  let l:cmd = 'ticard push'
  if exists('g:ticard_pandoc_enabled')
    let l:cmd = 'pandoc --to markdown --no-wrap | ' . l:cmd . ' | pandoc --to markdown'
  endif
  let l:cmd = '%! ' . l:cmd
  execute l:cmd
endfunction

function! s:TicardPull(url)
  let l:cmd = 'ticard pull ' . a:url
  if exists('g:ticard_pandoc_enabled')
    let l:cmd = l:cmd . ' | pandoc --to markdown'
  endif
  let l:cmd = '%! ' . l:cmd
  execute l:cmd
endfunction

function! s:Ticard(subcmd, ...)
  if a:subcmd ==? 'push'
    call s:TicardPush()
  else
    call s:TicardPull(a:1)
  endif
endfunction

function! s:Complete(arg_lead, cmd_line, cursor_pos)
  if !empty(matchstr(a:cmd_line, '\<push\>\|\<pull\>'))
    return ""
  endif
  return join(["pull", "push"], "\n")
endfunction

command! -nargs=* -complete=custom,s:Complete Ticard :call <SID>Ticard(<f-args>)

