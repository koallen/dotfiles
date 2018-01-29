" ==== vim-plug configuration section ===={{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" }}}

" ==== language server configuration section ===={{{

set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" }}}

" ==== deoplete.nvim configuration section ===={{{

let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" }}}

" ==== nerdtree configuration section ===={{{

" map :NERDTreeTabsToggle to <leader>t
map <Leader>t <plug>NERDTreeTabsToggle<CR>

" open on start up in console for directory
let g:nerdtree_tabs_open_on_console_startup = 2

" }}}

" ==== VIM-AIRLINE CONFIGURATION SECTION ===={{{

" set theme to wombat
let g:airline_theme='base16'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" always show the status bar
set laststatus=2

" }}}

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

" folding
set foldenable " enable folding
set foldmethod=syntax " fold according to syntax
set foldlevelstart=5   " open most folds by default"
nnoremap <space> za
autocmd BufRead init.vim setlocal foldmethod=marker " fold .vimrc with marker

" movement
nnoremap j gj
nnoremap k gk
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" color
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

colorscheme base16-default-dark

" }}}
