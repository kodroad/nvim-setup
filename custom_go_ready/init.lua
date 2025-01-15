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
opt.expandtab = false -- when inserting tab by pressing tab key don't replace it with spaces
opt.shiftwidth = 4 -- tab length when indenting with >> etc.
opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
opt.wrap = false
opt.diffopt:append("iwhite")
opt.fillchars:append({ diff = " " })
opt.autoread = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false -- don't fold everything on startup
opt.foldnestmax = 1

-- Go indent settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = false
	end,
})

-- YAML indent settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = true
	end,
})

-- Python indent settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.expandtab = false
	end,
})

-- Lua indent settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
		vim.opt.expandtab = false
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffText" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { link = "DiffDelete" })

local function mod_hl(hl_name, opts)
	local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
	if is_ok then
		for k, v in pairs(opts) do
			hl_def[k] = v
		end
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = autocmd_group,
	pattern = "*",
	callback = function()
		mod_hl("DiffviewDiffAddAsDelete", { fg = "NONE", bg = "#660000" })
	end,
})

-- Update buffers if files were changed outside of nvim
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = autocmd_group,
	pattern = { "*.yaml", "*.yml" },
	desc = "Auto-format YAML files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent !yamlfmt " .. fileName)
	end,
})
