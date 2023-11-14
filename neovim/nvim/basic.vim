set number relativenumber

let mapleader = ','

set ignorecase
nmap <leader>h :noh<CR>

nnoremap ,o  o<CR>
nnoremap ,O  O<ESC>O

" Browse through windows
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

set confirm

set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Toggle spell checking on and off
nmap <silent> <leader>s :set spell!<CR>

if !exists("g:ideavim")
    " Move inside wrapped lines.
    nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
    nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
    nnoremap <expr> 0 (v:count == 0 ? 'g0' : '0')
    nnoremap <expr> $ (v:count == 0 ? 'g$' : '$')
    nnoremap <expr> ^ (v:count == 0 ? 'g^' : '^')

    vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
    vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
    vnoremap <expr> 0 (v:count == 0 ? 'g0' : '0')
    vnoremap <expr> $ (v:count == 0 ? 'g$' : '$')
    vnoremap <expr> ^ (v:count == 0 ? 'g^' : '^')

    " this last allows to add semicols to the ends of visual blocks
    vnoremap g$ $
endif

" Don't wrap line in the middle of a word
set linebreak

" Set's '~' to behave like a operator
set tildeop

" Make motion keys 'h' and 'l' wrap on edges of lines
set whichwrap+=h,l

" New splits appear below(horizontal) or right(vertical)
set splitbelow splitright


" Some vim defaults changed by neovim

" Extracted from https://github.com/mikeslattery/nvim-defaults.vim/blob/main/plugin/.vimrc
" :help nvim-defaults

" Vim 7 options that differ

set nocompatible
if has('autocmd')
  filetype plugin indent on
endif

set backspace=indent,eol,start
set encoding=utf-8
set incsearch
set langnoremap nolangremap
set nrformats="bin,hex"
set ruler
set showcmd
set wildmenu

" Vim 7, 8 options that differ

set autoindent
set autoread
set background=dark
set belloff=all
set complete-=i
set display=lastline
set fillchars="vert:│,fold:·,sep:│,eob:~,lastline:@"
set formatoptions=tcqj
set nofsync
set hidden
set history=10000
set hlsearch
set nojoinspaces
set laststatus=2
set listchars="tab:> ,trail:-,nbsp:+"
set mouse=nvi
set mousemodel="popup_setpos"
set sidescroll=1
set smarttab
set nostartofline
set switchbuf=uselast
set tabpagemax=50
set tags="./tags;,tags"
set ttimeoutlen=50
set ttyfast
"TODO: set viewoptions+=unix,slash
set viewoptions-=options
let &viminfo='!,'.&viminfo
set wildoptions="pum,tagfile"


" Others extracted from https://neovim.io/doc/user/vim_diff.html#vim-differences
syntax on
set commentstring=""
"set sessionsoptions+="unix,slash"
set shortmess+=F
set shortmess-=S

set clipboard=unnamed,unnamedplus
