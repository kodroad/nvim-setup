---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },

		--  format with conform
		["<leader>fm"] = {
			function()
				require("conform").format()
			end,
			"formatting",
		},

		-- go to definition
		["<leader>d"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},

		-- tests
		["<leader>tn"] = { "<cmd> TestNearest <CR>", "Run the nearest test" },
		["<leader>tf"] = { "<cmd> TestFile <CR>", "Run tests in the current file" },
		["<leader>tl"] = { "<cmd> TestLast <CR>", "Run the last test" },

		-- Diffview
		["<leader>gd"] = { "<cmd> DiffviewOpen <CR>", "Open Diffview" },

		-- Neogit
		["<leader>gg"] = { "<cmd> Neogit <CR>", "Open Neogit" },
	},

	v = {
		[">"] = { ">gv", "indent" },
	},
}

M.tabufline = {
	plugin = true,

	n = {
		["<A-l>"] = {
			function()
				require("nvchad.tabufline").tabuflineNext()
			end,
			"Goto next (right) buffer",
		},

		["<A-h>"] = {
			function()
				require("nvchad.tabufline").tabuflinePrev()
			end,
			"Goto prev (left) buffer",
		},

		["<leader>co"] = {
			function()
				require("nvchad.tabufline").closeOtherBufs()
			end,
			"Close other buffers",
		},

		["<leader>cl"] = {
			function()
				require("nvchad.tabufline").closeBufs_at_direction("right")
			end,
			"Close buffers to right",
		},
	},
}

-- more keybinds!

return M
