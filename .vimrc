set nocompatible
set nonumber
set noshowmode
set nobackup
set noswapfile
set laststatus=2

syntax on
set paste
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set listchars=tab:<->
set list

let g:lightline = {
  \  'colorscheme': 'darcula',
  \  'active': {
  \    'left': [
  \        [ 'mode', 'paste' ],
  \        [ 'filename', 'lineinfo', 'modified' ]
  \    ],
  \    'right': [
  \        [ 'percent' ],
  \        [ 'fileformat', 'fileencoding', 'filetype' ]
  \    ]
  \  }
  \}
