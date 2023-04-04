require("packer").startup(function(use)
    use 'wbthomason/packer.nvim'

    use "tpope/vim-surround"
    use "ctrlpvim/ctrlp.vim"

    use 'ntpeters/vim-better-whitespace'

    if not vim.g.vscode then
        use 'preservim/nerdtree'

        use 'kyazdani42/nvim-web-devicons'
        use 'ryanoasis/vim-devicons'
        use 'romgrk/barbar.nvim'

        use 'airblade/vim-gitgutter'
        use 'morhetz/gruvbox'
        use 'christoomey/vim-tmux-navigator'

        use { 'codota/tabnine-nvim', run = "./dl_binaries.sh" }
    end
end)


-- load basic vim configs
vim.cmd('source ~/.config/nvim/basic.vim')


-- down here are configs that should be loaded only when
--  using neovim or embeded neovim

-- dynamic dark/light theme
local cmd = io.popen('global-theme get', "r")
local theme = cmd:read("*all")
cmd:close()

local theme = theme:gsub("\n", "")
vim.opt.background = theme


vim.cmd.colorscheme("gruvbox")
-- comments in italic case they look nice
vim.cmd.highlight("Comment cterm=italic")


vim.keymap.set("n", "<leader>v", "<cmd>tabedit ~/.config/nvim/init.lua<CR>")

vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>")


-- configure ntpeters/vim-better-whitespace
vim.g.strip_whitespace_on_save=1
vim.g.strip_whitespace_confirm=0
vim.g.strip_only_modified_lines=1
vim.g.strip_whitelines_at_eof=1
vim.g.show_spaces_that_precede_tabs=1

require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt"}
})

