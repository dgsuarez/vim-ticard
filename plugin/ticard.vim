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

command! RuboCop :call <SID>TicardPush

