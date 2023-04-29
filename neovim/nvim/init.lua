require('plugins')

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

if not vim.g.vscode then
  vim.keymap.set("n", "<leader>n", "<cmd>NERDTreeToggle<CR>")

  require('tabnine').setup({
    disable_auto_comment=true,
    accept_keymap="<Tab>",
    dismiss_keymap = "<C-]>",
    debounce_ms = 800,
    suggestion_color = {gui = "#808080", cterm = 244},
    exclude_filetypes = {"TelescopePrompt"}
  })
end

-- configure ntpeters/vim-better-whitespace
vim.g.strip_whitespace_on_save=1
vim.g.strip_whitespace_confirm=0
vim.g.strip_only_modified_lines=1
vim.g.strip_whitelines_at_eof=1
vim.g.show_spaces_that_precede_tabs=1
