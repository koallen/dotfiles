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
Plugin 'jiangmiao/auto-pairs'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'chriskempson/base16-vim'
Plugin 'w0rp/ale'

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

" ==== ALE CONFIGURATION SECTION ====

" always show sign gutter
let g:ale_sign_column_always = 1

" custom sign
let g:ale_sign_error = "✘"
let g:ale_sign_warning = "▲"

" ==== VIM CONFIGURATION SECTION ====

syntax on
au BufNewFile,BufRead *.cuh set filetype=cuda

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

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

colorscheme base16-default-dark
