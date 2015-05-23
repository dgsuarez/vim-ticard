if exists('g:loaded_ticard')
  finish
endif
let g:loaded_ticard = 1

if executable('pandoc') == 1 && !exists('g:ticard_pandoc_disabled')
  let s:pre_filter = 'pandoc --to markdown --no-wrap'
  let s:post_filter = 'pandoc --to markdown'
else
  let s:pre_filter = 'cat'
  let s:post_filter = 'cat'
endif

function! s:TicardPush()
  execute '%! ' . s:pre_filter . " | ticard push | " . s:post_filter
endfunction

function! s:TicardPull(url)
  let l:cmd = 'ticard pull ' . a:url
  execute '%! ' . l:cmd . " | " . s:post_filter
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

