function s:NonZero(cmd)
  if v:count == 0
    execute a:cmd
  else
    execute a:cmd v:count
  endif
endfunction

command -bang -count SoupBufDel call s:NonZero('bdelete<bang>')
command -count SoupBufGoto call s:NonZero('buffer')
command -count SoupBufNext call s:NonZero('bnext')
command -count SoupBufPrev call s:NonZero('bprevious')
command -count SoupTabClose call s:NonZero('tabclose')
command -count SoupTabNext call s:NonZero('tabnext')
command -count SoupTabPrevious call s:NonZero('tabprevious')
