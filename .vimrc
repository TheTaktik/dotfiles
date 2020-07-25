set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" Color scheme
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

" My stuff is accessed with spacebar
let mapleader = " "

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>ciw <Plug>(coc-rename)

set mouse=
filetype on
filetype indent on
syntax on
set tabstop=2
set shiftwidth=2
set expandtab

set number
set path+=**
set wildmenu
set relativenumber
set textwidth=80
set colorcolumn=+1

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·

" Enforce Purity!
inoremap <Up>     <Nop>
inoremap <Down>   <Nop>
inoremap <Left>   <Nop>
inoremap <Right>  <Nop>
inoremap <Down>   <Nop>
noremap <Up>      <Nop>
noremap <Down>    <Nop>
noremap <Left>    <Nop>
noremap <Right>   <Nop>
noremap <Down>    <Nop>

" NERDTree stuff
let g:NERDTreeWinPos = "right"

