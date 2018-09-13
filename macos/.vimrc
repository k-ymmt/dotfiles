syntax on
set number
colorscheme gruvbox

set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
nnoremap Q q
nnoremap q <Nop>

call plug#begin('~/.vim/plugged')
Plug 'zah/nim.vim'
call plug#end()

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

set backspace=indent,eol,start
