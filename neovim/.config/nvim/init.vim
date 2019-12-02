" ==== vim-plug configuration section ===={{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" }}}

" ==== NERDTree configuration section ===={{{

" open on start up in console for directory
augroup OpenNerdTreeOnDirectory
	autocmd!
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && 
		\ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p |
		\ ene | exe 'cd '.argv()[0] | wincmd p | endif
augroup END

" close when only nerdtree left
augroup CloseNerdTree
	autocmd!
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && 
		\ b:NERDTree.isTabTree()) | q | endif
augroup END

" ignore certain files and directories
let g:NERDTreeIgnore = ['^.git$', '^node_modules$']

" show hidden files by default in certain directories
augroup NerdTreeShowHiddenFiles
	autocmd!
	autocmd BufEnter ~/.dotfiles** let g:NERDTreeShowHidden = 1
augroup END

" }}}

"==== nerdcommenter configuration section ===={{{

vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

"}}}

" ==== vim-airline configuration section ===={{{

" set theme to wombat
let g:airline_theme='bubblegum'

" enable powerline fonts
let g:airline_powerline_fonts = 1

" always show the status bar
set laststatus=2

" configure open buffer tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_idx_format = {
	\ '0': '[0]',
	\ '1': '[1]',
	\ '2': '[2]',
	\ '3': '[3]',
	\ '4': '[4]',
	\ '5': '[5]',
	\ '6': '[6]',
	\ '7': '[7]',
	\ '8': '[8]',
	\ '9': '[9]',
	\ }


" }}}

" ==== indentLine configuration section ===={{{

let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_char = '|'
let g:indentLine_first_char = '|'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_showFirstIndentLevel = 1

" }}}

" ==== coc.nvim configuration section ===={{{

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" add some extensions
let g:coc_global_extensions = [
	\ 'coc-pairs',
	\ 'coc-python',
	\ 'coc-highlight',
	\ ]

" integrate with statusline
set statusline^=%{coc#status()}

" }}}

" ==== VIM CONFIGURATION SECTION ===={{{

" basic
set number " show line number
set relativenumber " show relative number
set showcmd " show last command in status line
set cursorline " highlight current line
set lazyredraw " redraw in a lazy fasion
set incsearch  " search as characters are entered
set hlsearch " highlight search results
set visualbell
set encoding=utf-8
set hidden " allow unsaved buffers to be hidden
let mapleader = ';'

" syntax highlighting
syntax enable
augroup FixJsonMarkdownConceal
	autocmd!
	autocmd BufEnter *.json,*.md let g:indentLine_setConceal = 0
	autocmd BufLeave *.json,*.md let g:indentLine_setConceal = 2
augroup END

" window splitting
set splitright

" indentation
set tabstop=4     " display tab as 4-space wide
set shiftwidth=4  " identation width when using << and >>
set list lcs=tab:\|\  " show a vertical bar for tabs

" folding
set foldenable " enable folding
set foldmethod=syntax " fold according to syntax
set foldlevelstart=5   " open most folds by default"
nnoremap <space> za

" movement
nnoremap j gj
nnoremap k gk
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Leader>a :bp<CR>
nnoremap <Leader>d :bn<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" color
if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

colorscheme base16-default-dark

" auto-reload init.vim on edit
augroup AutoReloadInitVim
	autocmd!
	autocmd BufWritePost */init.vim source $MYVIMRC | echon 'init.vim reloaded'
		\ | AirlineRefresh
augroup END
"hahaha

" }}}
