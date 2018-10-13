colorscheme gruvbox
set background=dark
set clipboard+=unnamed
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set mouse=a
set hlsearch
set showtabline=2
set list listchars=tab:\~\>

tnoremap <silent> <ESC> <C-\><C-n>

nnoremap q <Nop>

syntax on

let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1

if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})

 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


filetype plugin indent on
syntax enable

