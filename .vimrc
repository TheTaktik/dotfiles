set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tomtom/tcomment_vim'
Plugin 'morhetz/gruvbox'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Color scheme
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

" My stuff is accessed with spacebar
let mapleader = " "

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

