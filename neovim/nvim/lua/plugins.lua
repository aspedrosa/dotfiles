local check_vscode = { cond = function() return not vim.g.vscode end }

return require("packer").startup(function(use)
    use 'preservim/tagbar'
    use 'tpope/vim-commentary'

    use 'wbthomason/packer.nvim'

    use "tpope/vim-surround"
    use "ctrlpvim/ctrlp.vim"

    use 'ntpeters/vim-better-whitespace'

    use { 'preservim/nerdtree' }

    use { 'kyazdani42/nvim-web-devicons', requires = check_vscode }
    use { 'ryanoasis/vim-devicons', requires = check_vscode }
    use { 'romgrk/barbar.nvim', requires = check_vscode }

    use { 'airblade/vim-gitgutter', requires = check_vscode }
    use { 'morhetz/gruvbox', requires = check_vscode }
    use { 'christoomey/vim-tmux-navigator', requires = check_vscode }

    use { 'codota/tabnine-nvim', requires = check_vscode, run = "./dl_binaries.sh" }
end)
