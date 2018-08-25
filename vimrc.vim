set nocompatible              " be iMproved

set timeout ttimeoutlen=10

" Allow do mapping using alt keys
for i in range(48, 57) " [0-9]
  let c = nr2char(i)
  exec "set <M-".c.">=\e".c
endfor
for i in range(97, 122) " [a-z]
  let c = nr2char(i)
  exec "set <M-".c.">=\e".c
endfor

let mapleader = ','
" Inserted when vundle was intalled
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

" Enables mouse on vim
set mouse=a

set background=dark

" Only enable syntax highlighting if the terminal supports colors
if &t_Co > 1
  syntax on
  colorscheme gruvbox
endif

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

" Browse through tabs
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt

" Will cause problem if I install YouCompleteMe
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

" Don't wrap line in the middle of a word
set linebreak

" When I move to the end of the file, scroll 5 lines up to see better where
"   I'm working
set scrolloff=5
"If I want to go to line 49 -> 49G - BUG TODO
nnoremap G G5<C-e>

" Set's '~' to behave like a operator
set tildeop

"Restores the cursor back to where he was the last time I edited a certain
"  file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Make motion keys 'h' and 'l' wrap on edges of lines
set whichwrap+=h,l
