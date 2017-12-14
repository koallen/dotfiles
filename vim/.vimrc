" ==== VUNDLE CONFIGURATION SECTION ===={{{

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
"Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'chriskempson/base16-vim'
Plugin 'Yggdroot/indentLine'
Plugin 'w0rp/ale'
Plugin 'editorconfig/editorconfig-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"}}}

" ==== NERD TREE (TABS) CONFIGURATION SECTION ===={{{

" map :NERDTreeTabsToggle to <leader>t
map <Leader>t <plug>NERDTreeTabsToggle<CR>

" open on start up in console for directory
let g:nerdtree_tabs_open_on_console_startup = 2

"}}}

" ==== VIM-AIRLINE CONFIGURATION SECTION ===={{{

" set theme to wombat
let g:airline_theme='base16'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" always show the status bar
set laststatus=2

"}}}

" ==== NEOCOMPLETE CONFIGURATION SECTION ===={{{

" enable neocomplete
"let g:neocomplete#enable_at_startup = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"}}}

" ==== ALE CONFIGURATION SECTION ===={{{

" always show sign gutter
let g:ale_sign_column_always = 1

" custom sign
let g:ale_sign_error = "✘"
let g:ale_sign_warning = "▲"

"}}}

" ==== EDITORCONFIG CONFIGURATION SECTION ===={{{

" avoid conflict with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
"}}}

" ==== VIM CONFIGURATION SECTION ===={{{

" basic
set number " show line numbers
set showcmd " show last command in status line
set cursorline " highlight current line
set lazyredraw " redraw in a lazy fasion
set incsearch  " search as characters are entered
set hlsearch " highlight search results
set visualbell
set encoding=utf-8
set backspace=indent,eol,start

" syntax highlighting
au BufNewFile,BufRead *.cuh set filetype=cuda
syntax enable " enable syntax highlighting

" movement
nnoremap j gj
nnoremap k gk
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" indentation
set tabstop=4     " display tab as 4-space wide
set shiftwidth=4  " identation width when using << and >>
set list lcs=tab:\|\ 
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '|'
let g:indentLine_first_char = '|'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_showFirstIndentLevel = 1

" folding
set foldenable " enable folding
set foldmethod=syntax " fold according to syntax
set foldlevelstart=5   " open most folds by default"
nnoremap <space> za
autocmd BufRead .vimrc setlocal foldmethod=marker " fold .vimrc with marker

" color
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

colorscheme base16-default-dark

"}}}
