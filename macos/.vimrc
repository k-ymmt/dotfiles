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

let g:airline_theme = 'zenburn'
let g:airline#extensions#tabline#enabled = 1

if &compatible
 set nocompatible
endif

filetype plugin indent on
syntax enable

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
