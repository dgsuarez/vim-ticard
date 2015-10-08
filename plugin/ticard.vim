if exists('g:loaded_ticard')
  finish
endif
let g:loaded_ticard = 1

if executable('pandoc') == 1 && !exists('g:ticard_pandoc_disabled')
  let s:pre_filter =  'pandoc --to markdown_github'
  let s:post_filter = 'pandoc --from markdown_github --to markdown_github | pandoc --to markdown | pandoc --from markdown_github --to markdown_github'
else
  let s:pre_filter = 'cat'
  let s:post_filter = 'cat'
endif

function! s:TicardPush()
  execute '%w ! ticard check'
  if v:shell_error == 0 || confirm("Card has changed, overwrite?", "&Yes\n&No", 2) == 1
    execute '%! ' . s:pre_filter . " | ticard push --force | " . s:post_filter
  endif
endfunction

function! s:TicardPull(url)
  let l:cmd = 'ticard pull ' . a:url
  execute "enew"
  execute '%! ' . l:cmd . " | " . s:post_filter
  execute "setf markdown"
endfunction

function! s:Ticard(subcmd, ...)
  let l:line = line(".")
  if a:subcmd ==? 'push'
    call s:TicardPush()
  else
    call s:TicardPull(a:1)
  endif
  execute ":" . l:line
endfunction

function! s:Complete(arg_lead, cmd_line, cursor_pos)
  if !empty(matchstr(a:cmd_line, '\<push\>\|\<pull\>'))
    return ""
  endif
  return join(["pull", "push"], "\n")
endfunction

command! -nargs=* -complete=custom,s:Complete Ticard :call <SID>Ticard(<f-args>)

