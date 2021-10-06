set nocompatible              " be iMproved

let g:python3_host_prog = '/usr/bin/python3.9'

set timeout ttimeoutlen=10

" After exit insert mode a ^] (escape character) is inserted.
"   With this mapping that character is canceled
" inoremap <ESC> <ESC><ESC>

let mapleader = ','

" Enables mouse on vim
set mouse=a

set background=dark
if !exists("g:ideavim")
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
    Plugin 'tranvansang/octave.vim'
    Plugin 'morhetz/gruvbox'
    Plugin 'ntpeters/vim-better-whitespace'

    call vundle#end()            " required
    filetype plugin indent on    " required
endif

let g:gruvbox_italic=1

" Only enable syntax highlighting if the terminal supports colors
if &t_Co > 1
  set termguicolors
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

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-tab>" "Not Working

set wildmenu
set confirm

" Toggle spell checking on and off
nmap <silent> <leader>s :set spell!<CR>

if has("autocmd")
  " Edit vimrc on the fly
  " autocmd bufwritepost vimrc.vim source ~/dotfiles/vimrc.vim

  " autocmd BufRead,BufNewFile *.tex set filetype=tex | set textwidth=87 " textwith with splitscreen of my pc

  autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2

  " Keep the clipboard after leaving vim
  autocmd VimLeave * call system("xsel -ib", getreg('+'))

  if executable("xsel")
    function! PreserveClipboard()
      call system("xsel -ib", getreg('+'))
    endfunction

    function! PreserveClipboadAndSuspend()
      call PreserveClipboard()
      suspend
    endfunction

    autocmd VimLeave * call PreserveClipboard()
    nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
    vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>
  endif
endif

" Compile mappings
nnoremap <leader>cl :w<CR>:!latexmake<CR>
nnoremap <leader>cb :w<CR>:!bibtexmake<CR>
nnoremap <leader>cm :w<CR>:!make -j 12<CR>

" After a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Map to start editing the vimrc file
nmap <leader>v :tabedit ~/dotfiles/vimrc.vim<CR>

" Toggle NerdTree
nmap <leader>n :NERDTreeToggle<CR>

" Display NerdTree on all tabs
autocmd BufWinEnter * silent NERDTreeMirror

" Show hidden files
let g:NERDTreeShowHidden=1

" Change arrows of NERDTree.
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

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
endif

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

" vnoremap <leader>f gq
set formatoptions+=ro

hi SpellBad cterm=underline
hi SpellCap cterm=underline
hi SpellRare cterm=underline
hi SpellLocal cterm=underline


" When vim is executed with multiple files as argument open
"   all of them in tabs
silent tab all
