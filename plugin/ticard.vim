if exists('g:loaded_ticard')
  "finish
endif
let g:loaded_ticard = 1

function! s:TicardPush()
  let l:cmd = 'ticard push'
  if exists('g:ticard_pandoc_enabled')
    let l:cmd = 'pandoc --to markdown --no-wrap | ' . l:cmd . ' | pandoc --to markdow'
  endif
  let l:cmd = '%! ' . l:cmd
  execute l:cmd
endfunction

function! s:TicardPull(url)
  let l:cmd = 'ticard pull ' . a:url
  if exists('g:ticard_pandoc_enabled')
    let l:cmd = l:cmd . ' | pandoc --to markdow'
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


command! -nargs=* Ticard :call <SID>Ticard(<f-args>)

