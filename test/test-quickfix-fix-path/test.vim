set nocompatible
let &rtp = '../..,' . &rtp
filetype plugin on

nnoremap q :qall!<cr>

set nomore

silent edit main.tex

if empty($INMAKE) | finish | endif

try
  silent call vimtex#qf#setqflist()
catch /VimTeX: No log file found/
  echo 'VimTeX: No log file found'
  cquit
endtry

let s:qf = getqflist()
call assert_equal(4, len(s:qf))
call assert_equal('./test.tex', bufname(s:qf[1].bufnr))
call assert_equal('./test.tex', bufname(s:qf[2].bufnr))
call assert_equal('test-new.tex', bufname(s:qf[3].bufnr))

call vimtex#test#finished()
