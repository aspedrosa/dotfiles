""set nocompatible              " be iMproved

""let g:python3_host_prog = '/usr/bin/python3'

""let mapleader = ','

" Enables mouse on all modes
""set mouse=a

"" execute "set background=" . system("global-theme get")

" When using ideavim (JetBrains vim plugin), dont import plugins
" VSCode will use SOME plugins since there is a plugin that embeds neovim
if !exists("g:ideavim")
    call plug#begin()

    Plug 'tpope/vim-surround'
    Plug 'ctrlpvim/ctrlp.vim'

    Plug 'ntpeters/vim-better-whitespace'

    if !exists("g:vscode")
        Plug 'preservim/nerdtree'

        Plug 'kyazdani42/nvim-web-devicons'
        Plug 'ryanoasis/vim-devicons'
        Plug 'romgrk/barbar.nvim'

        Plug 'airblade/vim-gitgutter'
        Plug 'morhetz/gruvbox'
        Plug 'christoomey/vim-tmux-navigator'

        Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
    endif

    call plug#end()
endif

let g:gruvbox_italic=1

" Only enable syntax highlighting if the terminal supports colors
""if &t_Co > 1
""  syntax on
""  colorscheme gruvbox
""endif

"enable italic comments
""highlight Comment cterm=italic
set t_ZH=[3m
set t_ZR=[23m

""set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
""
""set number relativenumber
""
""" Ignore case on searches
""set ignorecase
""nmap ,h :noh<CR>
""
""nnoremap ,o  o<CR>
""nnoremap ,O  O<ESC>O
""
""" Browse through windows
""nmap <C-h> <C-W>h
""nmap <C-j> <C-W>j
""nmap <C-k> <C-W>k
""nmap <C-l> <C-W>l

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

""set confirm

" Toggle spell checking on and off
""nmap <silent> <leader>s :set spell!<CR>

"" autocmd commands
" Edit init.vim on the fly
"autocmd bufwritepost init.vim source ~/.config/nvim/init.vim

""autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
""autocmd FileType js setlocal shiftwidth=2 tabstop=2 softtabstop=2

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

" Compile mappings
nnoremap <leader>cl :w<CR>:!latexmake<CR>
nnoremap <leader>cb :w<CR>:!bibtexmake<CR>
nnoremap <leader>cm :w<CR>:!make -j 12<CR>

" Map to start editing the vimrc file
""nmap <leader>v :tabedit ~/.config/nvim/init.vim<CR>


" Toggle NERDTree
""nmap <leader>n :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


""if !exists("g:ideavim")
""    " Move inside wrapped lines.
""    nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
""    nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
""    nnoremap <expr> 0 (v:count == 0 ? 'g0' : '0')
""    nnoremap <expr> $ (v:count == 0 ? 'g$' : '$')
""    nnoremap <expr> ^ (v:count == 0 ? 'g^' : '^')
""
""    vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
""    vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
""    vnoremap <expr> 0 (v:count == 0 ? 'g0' : '0')
""    vnoremap <expr> $ (v:count == 0 ? 'g$' : '$')
""    vnoremap <expr> ^ (v:count == 0 ? 'g^' : '^')
""endif

" Don't wrap line in the middle of a word
"set linebreak

" When I move to the end of the file, scroll 5 lines up to see better where
"   I'm working
set scrolloff=5

""" Set's '~' to behave like a operator
""set tildeop

"Restores the cursor back to where he was the last time I edited a certain
"  file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

""" Make motion keys 'h' and 'l' wrap on edges of lines
""set whichwrap+=h,l

""" New splits appear below(horizontal) or right(vertical)
""set splitbelow splitright

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


"let g:strip_whitespace_on_save=1
"let g:strip_whitespace_confirm=0
"let g:strip_only_modified_lines=1
"let g:strip_whitelines_at_eof=1
"let g:show_spaces_that_precede_tabs=1


""if !exists('g:ideavim')
""if !exists('g:vscode')
""
""lua << EOF
""require('tabnine').setup({
""  disable_auto_comment=true,
""  accept_keymap="<Tab>",
""  dismiss_keymap = "<C-]>",
""  debounce_ms = 800,
""  suggestion_color = {gui = "#808080", cterm = 244},
""  exclude_filetypes = {"TelescopePrompt"}
""})
""EOF
""
""endif
""endif
