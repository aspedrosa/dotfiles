set nocompatible              " be iMproved

set timeout ttimeoutlen=10

" After exit insert mode a ^] (escape character) is inserted.
"   With this mapping that character is canceled
inoremap <ESC> <ESC><ESC>

" Allow mappings to use alt keys
for i in range(48, 57) " [0-9]
  let c = nr2char(i)
  exec "set <M-".c.">=\e".c
endfor
for i in range(97, 122) " [a-z]
  let c = nr2char(i)
  exec "set <M-".c.">=\e".c
endfor

let mapleader = ','
" Inserted when vundle was installed
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
" Ignore case on searches
set ignorecase
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

" Toggle spell checking on and off
nmap <silent> <leader>s :set spell!<CR>

" Edit vimrc on the fly
if has("autocmd")
  autocmd bufwritepost vimrc.vim source ~/dotfiles/vimrc.vim
endif

" TODO dont edit the real vimrc file
nmap <leader>v :tabedit ~/dotfiles/vimrc.vim<CR>

" Move text in file up and down
nmap <A-k> ddkP
nmap <A-j> ddp
vmap <A-k> dkP'[V']
vmap <A-j> dp '[V']

" Toggle NerdTree
nmap <leader>n :NERDTreeToggle<CR>
" Show hidden files
let g:NERDTreeShowHidden=1
" Change arrows of NERDTree.
" TODO I need to change encoding for the original arrows to work
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'

" Move inside wrapped lines.
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

" New splits appear below(horizontal) or right(vertical)
set splitbelow splitright

" Sets encoding (not having this set was giving me problem on NERDTree)
" BUT this mess up alt keys and they don't work
" set encoding=utf-8

" Whenever I enter a NERDTree buffer check if is the only window, if is quit
autocmd WinEnter *
    \ if winnr('$') == 1 && exists("t:NERDTreeBufName") && winnr() == bufwinnr(t:NERDTreeBufName) |
    \   quit |
    \ endif
