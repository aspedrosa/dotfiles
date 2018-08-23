set timeout ttimeoutlen=10

" Allow do mapping using alt keys
for i in range(97, 122)
  let c = nr2char(i)
  exec "set <M-".c.">=\e".c
endfor

let mapleader = ','
" Inserted when vundle was intalled
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sirver/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

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

set mouse=a
syntax on
syntax enable
set background=dark
colorscheme gruvbox

"autocmd BufRead,BufNewFile *.g4 setfiletype antlr4
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

set number relativenumber

set showcmd

" Highlighting on typing, highlighting matches (don't remember what 'is' is
"   for)
set incsearch hlsearch is
nmap ,h :noh<CR>

nnoremap ,o  o<CR>
nnoremap ,O  O<ESC>O

" Browse through windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Browse through tabs like chrome
map ,1 1gt
map ,2 2gt
map ,3 3gt
map ,4 4gt
map ,5 5gt
map ,6 6gt
map ,7 7gt
map ,8 8gt
map ,9 9gt

" vai dar problemas caso intale o YouCompleteMe
let g:UltiSnipsExpandTrigger="<tab>"

set wildmenu
set confirm

"Toggle spell checking on and off with ',s'
nmap <silent> <leader>s :set spell!<CR>

"Edit vimrc on the fly
if has("autocmd")
  autocmd bufwritepost vimrc.vim source ~/dotfiles/vimrc.vim
endif

" TODO dont edit the real vimrc file
nmap <leader>v :tabedit ~/dotfiles/vimrc.vim<CR>

"move text in file up and down (nao funcionam) alt
nmap <A-k> ddkP
nmap <A-j> ddp
vmap <A-k> dkP'[V']
vmap <A-j> dp '[V']

"Toggle NerdTree
nmap <leader>n :NERDTreeToggle<CR>

" move inside wrapped lines.
nmap j gj
nmap k gk
nmap 0 g0
nmap $ g$
vmap j gj
vmap k gk
vmap 0 g0
vmap $ g$
set linebreak

" When I move to the end of the file, scroll 5 lines up to see better where
"   I'm working
set scrolloff=5
"If I want to go to line 49 -> 49G - BUG TODO
nmap G G5<C-e>

" Set's '~' to behave like a operator
set tildeop
