-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = true,
	},

	DiffAdd = { fg = "NONE", bg = "#004400" },
	DiffText = { fg = "#000000", bg = "#ffa500" },
	DiffChange = { fg = "NONE", bg = "#454545" },
	DiffDelete = { fg = "NONE", bg = "#660000" },
	DiffRemoved = { fg = "NONE", bg = "#660000" },
	FloatBorder = { fg = "#454545", bg = "NONE" },
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },

	NeogitHunkHeader = { fg = "white", bg = "black" },
	NeogitDiffAdd = { fg = "NONE", bg = "#004400" },
	NeogitDiffDelete = { fg = "NONE", bg = "#660000" },
	NeogitDiffHeader = { fg = "white", bg = "black" },

	NeogitHunkHeaderHighlight = { fg = "white", bg = "black" },
	NeogitDiffAddHighlight = { fg = "NONE", bg = "#004400" },
	NeogitDiffDeleteHighlight = { fg = "NONE", bg = "#660000" },
	NeogitDiffHeaderHighlight = { fg = "white", bg = "black" },
}

return M
