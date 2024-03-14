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
opt.diffopt:append("iwhite")
opt.fillchars:append({ diff = " " })
opt.autoread = true

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("lint").try_lint()
	end,
})

local function mod_hl(hl_name, opts)
	local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
	if is_ok then
		for k, v in pairs(opts) do
			hl_def[k] = v
		end
		vim.api.nvim_set_hl(0, hl_name, hl_def)
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = vim.api.nvim_create_augroup("Color", {}),
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
