if exists('g:loaded_lightline') || v:version < 703
  finish
endif
let g:loaded_lightline = 1

let s:save_cpo = &cpo
set cpo&vim

augroup lightline
  autocmd!
  autocmd WinEnter,BufEnter,SessionLoadPost,FileChangedShellPost * call lightline#update()
  if !has('patch-8.1.1715')
    autocmd FileType qf call lightline#update()
  endif
  autocmd SessionLoadPost * call lightline#highlight()
  autocmd ColorScheme * if !has('vim_starting') || expand('<amatch>') !=# 'macvim'
        \ | call lightline#update() | call lightline#highlight() | endif
augroup END

let g:qf_disable_statusline = 1

let &cpo = s:save_cpo
unlet s:save_cpo
