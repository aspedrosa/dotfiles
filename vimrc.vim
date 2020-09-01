set nocompatible              " be iMproved

set timeout ttimeoutlen=10

" After exit insert mode a ^] (escape character) is inserted.
"   With this mapping that character is canceled
" inoremap <ESC> <ESC><ESC>

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
Plugin 'sirver/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mkitt/tabline.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'airblade/vim-gitgutter'

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

"enable italic comments
highlight Comment cterm=italic
set t_ZH=[3m
set t_ZR=[23m

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

set number relativenumber

set showcmd

" Highlighting on typing, highlighting matches
set incsearch hlsearch
" Ignore case on searches
set ignorecase
nmap ,h :noh<CR>

nnoremap ,o  o<CR>
nnoremap ,O  O<ESC>O

" Browse through windows
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" Browse through tabs - Not working
nnoremap <Esc>1 1gt
nnoremap <Esc>2 2gt
nnoremap <Esc>3 3gt
nnoremap <Esc>4 4gt
nnoremap <Esc>5 5gt
nnoremap <Esc>6 6gt
nnoremap <Esc>7 7gt
nnoremap <Esc>8 8gt
nnoremap <Esc>9 9gt

" UltiSnips and YouCompleteMe
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-tab>" "Not Working

let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']

set wildmenu
set confirm

" Toggle spell checking on and off
nmap <silent> <leader>s :set spell!<CR>

if has("autocmd")
  " Edit vimrc on the fly
  " autocmd bufwritepost vimrc.vim source ~/dotfiles/vimrc.vim

  " Syntax for some specific files
  "autocmd BufRead,BufNewFile *.g4 setfiletype antlr4
  autocmd BufRead,BufNewFile *.m set ft=octave

  autocmd BufRead,BufNewFile *.tex set filetype=tex | set textwidth=89 " textwith with splitscreen of my pc

  autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2
endif

" Compile mappings
nnoremap <leader>cl :w<CR>:!latexmake<CR>
nnoremap <leader>cb :w<CR>:!bibtexmake<CR>

" After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Map to start editing the vimrc file
nmap <leader>v :tabedit ~/dotfiles/vimrc.vim<CR>

" Toggle NerdTree
nmap <leader>n :NERDTreeToggle<CR>

" Show hidden files
let g:NERDTreeShowHidden=1

" Change arrows of NERDTree.
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

" Sets encoding (not having this set was giving me problem on NERDTree)
" BUT this mess up alt keys. For them to work I need to change for loops
" on top of this file
set encoding=utf-8


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

" Don't wrap line in the middle of a word
set linebreak

" When I move to the end of the file, scroll 5 lines up to see better where
"   I'm working
set scrolloff=5

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

" Whenever I enter a NERDTree buffer check if is the only window, if it is quit
autocmd WinEnter *
    \ if winnr('$') == 1 && exists("t:NERDTreeBufName") && winnr() == bufwinnr(t:NERDTreeBufName) |
    \   quit |
    \ endif

" Useful if developing bash/c/c++. Allow that man pages can be seen inside vim
"   in a buffer. Ex: Man 3 printf
runtime! ftplugin/man.vim

" Don't save options and mappings of session (To save space. All those
"   mappings and options are on vimrc)
" However if I have a help page open (of vim) all of it's usual options are not gonna
"   be loaded (ex: nonumbers)
set sessionoptions-=options

" Autoclose documentation window after I select a result (YouCompleteMe)
" let g:ycm_autoclose_preview_window_after_completion = 1

" keep signcolumn always open. This way, with youcompleteme, terminal isn't
" always flashing to update the view
"set signcolumn=yes

" disable syntastic on java
let g:syntastic_java_checkers = []

" option for syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'

" Change cursor shape when entering insert mode to just a vertical bar
" instead of a block
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' |
"     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif

" Make vim use sistem clipboard
set clipboard=unnamedplus 

" Transparent backgroung
hi Normal guibg=NONE ctermbg=NONE

" Remove toolbar, menubar and scroolbars on gvim
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

vnoremap <leader>f gq
set formatoptions+=ro

hi SpellBad cterm=underline
hi SpellCap cterm=underline
hi SpellRare cterm=underline
hi SpellLocal cterm=underline

" shortcuts to save and quit
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :wq<CR>

" When vim is executed with multiple files as argument open
"   all of them in tabs
silent tab all
