" ==== vim-plug configuration section ===={{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin' " show git status in NERDTree
Plug 'itchyny/lightline.vim' " a light weight status line
Plug 'mengelbrecht/lightline-bufferline' " display list of buffers
Plug 'junegunn/fzf'
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator' " integration between tmux and vim

" syntax highlighting plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'saltstack/salt-vim' " syntax highlighting for SaltStack
Plug 'lepture/vim-jinja' " syntax highlighting for Jinja

" LSP plugins
Plug 'williamboman/mason.nvim', {'tag': 'v1.9.0'}
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" completion plugins
Plug 'hrsh7th/cmp-nvim-lsp' " provide completion from LSP server
Plug 'hrsh7th/cmp-buffer' " provide completion from buffer
Plug 'hrsh7th/nvim-cmp'

" theme plugins
Plug 'tinted-theming/base16-vim'

call plug#end()

" }}}

let g:python3_host_prog = '$HOME/.pyenv/versions/neovim/bin/python'

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

" ==== LSP configuration section ===={{{

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup{
    ensure_installed = {"rust_analyzer", "pylsp", "bashls", "clangd"}
}
require("lspconfig").rust_analyzer.setup{}
require("lspconfig").pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    maxLineLength = 100
                }
            }
        }
    }
}
require("lspconfig").bashls.setup{}
require("lspconfig").clangd.setup{}

-- make hover window narrower
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        width = 100,
    }
)

-- show documentation by pressing K
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = args.buf})
        end
    end,
})
EOF

" }}}

" ==== completion configuration section ===={{{

lua << EOF
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- scroll doc backward
        ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- scroll doc forward
        ["<C-Space>"] = cmp.mapping.complete(),            -- force trigger the completion window
        ["<C-e>"] = cmp.mapping.abort(),                   -- close complete window
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- accept completion with Enter
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
})
EOF

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

lua << EOF
require("nvim-treesitter.configs").setup{
    ensure_installed = { "bash", "c", "cpp", "cuda", "javascript", "json", "lua", "python", "yaml", "vim", "vimdoc" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
EOF

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
let base16colorspace=256
colorscheme base16-default-dark

" }}}
