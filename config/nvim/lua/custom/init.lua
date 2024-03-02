-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local g = vim.g
local opt = vim.opt

g.mapleader = ","
g.nvim_tree_auto_close = true

-- Indenting
opt.expandtab = false
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 0
opt.wrap = false

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    require("lint").try_lint()
  end,
})

-- Toggle lazygit
vim.api.nvim_create_autocmd("VimEnter", {
  command = "FloatermNew --silent --name=lazygit-floaterm --height=1.0 --width=1.0 --title=lazygit --position=topleft lazygit",
})
vim.keymap.set("n", "<A-m>", function()
  vim.cmd "FloatermToggle lazygit-floaterm"
end)
vim.keymap.set("t", "<A-m>", function()
  vim.cmd "FloatermToggle lazygit-floaterm"
end)
