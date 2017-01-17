" ==== VUNDLE CONFIGURATION SECTION ====

set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'dracula/vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ==== NERD TREE (TABS) CONFIGURATION SECTION ====

" map :NERDTreeTabsToggle to <leader>t
map <Leader>t <plug>NERDTreeTabsToggle<CR>

" open on start up in console for directory
let g:nerdtree_tabs_open_on_console_startup = 2

" ==== VIM-AIRLINE CONFIGURATION SECTION ====

" set theme to wombat
let g:airline_theme='wombat'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" always show the status bar
set laststatus=2

" ==== NEOCOMPLETE CONFIGURATION SECTION ====

" enable neocomplete
let g:neocomplete#enable_at_startup = 1

" ==== SYNTASTIC CONFIGURATION SECTION ====

hi clear SignColumn

let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"

" ==== VIM CONFIGURATION SECTION ====

syntax on
set number
set showcmd
set incsearch
set hlsearch
set visualbell
set encoding=utf-8
set backspace=indent,eol,start

" indentation
set tabstop=4
set shiftwidth=4

" ==== THEME CONFIGURATION SECTION ====

color dracula
