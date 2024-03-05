local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"c",
		"markdown",
		"markdown_inline",
		"go",
	},
	indent = {
		enable = true,
		-- disable = {
		--   "python"
		-- },
	},
}

M.mason = {
	ensure_installed = {
		"gopls",
		"goimports",
		"gofumpt",
		"golangci-lint",
	},
}

-- git support in nvimtree
M.nvimtree = {
	git = {
		enable = true,
	},

	renderer = {
		highlight_git = true,
		icons = {
			show = {
				git = true,
			},
		},
	},
}

return M
