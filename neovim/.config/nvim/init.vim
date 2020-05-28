" ==== vim-plug configuration section ===={{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'saltstack/salt-vim'
Plug 'lepture/vim-jinja'
Plug 'christoomey/vim-tmux-navigator'

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
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && 
        \ b:NERDTree.isTabTree()) | q | endif
augroup END

" ignore certain files and directories
let g:NERDTreeIgnore = [
    \ '^\.git$',
    \ '^node_modules$',
    \ '\.egg-info$',
    \ '\.pyc',
    \ '^build$',
    \ '^dist$',
    \ '^__pycache__$',
    \ '^\.cache$',
    \ '^\.venv$',
    \ '^\.pytest_cache$',
    \ ]

" show hidden files by default
let g:NERDTreeShowHidden = 1

" automatically delete buffer for files deleted in NERDTree
let g:NERDTreeAutoDeleteBuffer = 1

" }}}

"==== nerdcommenter configuration section ===={{{

vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

let g:NERDSpaceDelims = 1

"}}}

" ==== lightline.vim configuration section ===={{{

" no need to display mode as it's displayed in the status line
set noshowmode

" set theme to wombat
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'mtime'] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'inactive' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'buffers' ] ],
    \   'right': [ ]
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ },
    \ 'component_function': {
    \   'inactive': 'CustomLightlineInactive',
    \   'mode': 'CustomLightlineMode',
    \   'paste': 'CustomLightlinePaste',
    \   'mtime': 'CustomLightlineMtime',
    \   'readonly': 'CustomLightlineReadOnly',
    \   'filename': 'CustomLightlineFilename',
    \   'modified': 'CustomLightlineModified',
    \   'percent': 'CustomLightlinePercent',
    \   'lineinfo': 'CustomLightLineLineInfo',
    \   'fileformat': 'CustomLightLineFileFormat',
    \   'fileencoding': 'CustomLightLineFileEncoding',
    \   'filetype': 'CustomLightLineFileType',
    \ },
    \ }


" always show the status line and buffer line
set laststatus=2
set showtabline=2

" show buffer ordinal number
let g:lightline#bufferline#show_number = 2

" custom function to disable status line info inside NERDTree window
function! CustomLightlineMode()
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? 'NERDTree' :
    \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CustomLightlineInactive()
    let mode = CustomLightlineMode()
    return mode ==# lightline#mode() ? expand('%:t') : mode
endfunction

function! CustomLightlinePaste()
    return CustomLightlineMode() !=# lightline#mode() ? '' :
    \ &paste ? 'PASTE' : ''
endfunction

function! CustomLightlineReadOnly()
    return CustomLightlineMode() !=# lightline#mode() ? '' :
    \ &readonly ? 'RO' : ''
endfunction

function! CustomLightlineMtime()
    return CustomLightlineMode() ==# lightline#mode() ? strftime('%Y-%m-%d %H:%M:%S',getftime(expand('%'))) : ''
endfunction

function! CustomLightlineFilename()
    return CustomLightlineMode() ==# lightline#mode() ? expand('%:t') : ''
endfunction

function! CustomLightlineModified()
    return CustomLightlineMode() !=# lightline#mode() ? '' :
    \ &modified ? '+' : ''
endfunction

function! CustomLightlinePercent()
    return CustomLightlineMode() ==# lightline#mode() ? line('.') * 100 / line('$') . '%' : ''
endfunction

function! CustomLightLineLineInfo()
    return CustomLightlineMode() ==# lightline#mode() ? line('.').':'. col('.') : ''
endfunction

function! CustomLightLineFileFormat()
    return CustomLightlineMode() ==# lightline#mode() ? &ff : ''
endfunction

function! CustomLightLineFileEncoding()
    return CustomLightlineMode() ==# lightline#mode() ? &fileencoding : ''
endfunction

function! CustomLightLineFileType()
    return CustomLightlineMode() ==# lightline#mode() ? &filetype : ''
endfunction

" }}}

" ==== indentLine configuration section ===={{{

let g:indentLine_char = '¦'

" }}}

" ==== coc.nvim configuration section ===={{{

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" add some extensions
let g:coc_global_extensions = [
    \ 'coc-pairs',
    \ 'coc-python',
    \ 'coc-json',
    \ 'coc-highlight',
    \ 'coc-snippets',
    \ ]

" coc-snippets key mapping
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)

" }}}

" ==== vim-tmux-navigator configuration section ===={{{

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

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
augroup ViewVueAsHtml
    autocmd!
    autocmd BufNewFile,BufRead *.vue setlocal filetype=html
augroup END

" window splitting
set splitright
set splitbelow

" indentation
set tabstop=4     " display tab as 4-space wide
set shiftwidth=4  " identation width when using << and >>
set expandtab     " use space instead of tab
set softtabstop=4 " insert and delete 4 space
set list lcs=tab:\|\  " show a vertical bar for tabs

" folding
set foldenable " enable folding
set foldmethod=syntax " fold according to syntax
set foldlevelstart=5   " open most folds by default"
nnoremap <space> za

" movement
nnoremap j gj
nnoremap k gk
nnoremap <C-J> :resize -5<CR>
nnoremap <C-K> :resize +5<CR>
nnoremap <C-L> :vertical:resize +5<CR>
nnoremap <C-H> :vertical:resize -5<CR>
nnoremap <Leader>a :bp<CR>
nnoremap <Leader>d :bn<CR>
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
nnoremap <Leader>f :NERDTreeFocus<CR>

" color
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" }}}
