local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require("lint").linters_by_ft = {
        go = { "golangcilint" },
      }

      local golangcilint = require("lint").linters.golangcilint
      golangcilint.args = {
        "run",
        "--out-format",
        "json",
      }

      -- Show linter name in a diagnostic message.
      local ns = require("lint").get_namespace "golangcilint"
      vim.diagnostic.config({ virtual_text = { source = true } }, ns)
    end,
  },

  {
    "vim-test/vim-test",
    lazy = false,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      local actions = require "diffview.actions"

      require("diffview").setup {
        enhanced_diff_hl = true,
        file_panel = {
          listing_style = "list",
        },
        keymaps = {
          view = {
            { "n", "<esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
          },
          file_panel = {
            { "n", "<esc>", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
            { "n", "j", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "k", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
          },
        },
      }
    end,
  },

  {
    "NeogitOrg/neogit",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup {
        mappings = {
          status = {
            ["<esc>"] = "Close",
            ["o"] = "Toggle",
          },
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          i = {
            -- Close Telescope on single Esc press
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local opts = require "plugins.configs.cmp"
      local cmp = require "cmp"

      opts.mapping["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select }
      opts.mapping["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }

      return opts
    end,
  },

  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup {
        terminals = {
          type_opts = {
            float = {
              row = 0.2,
              col = 0.1,
              width = 0.8,
              height = 0.6,
            },
          },
        },
      }
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("scrollbar").setup {
        max_lines = 5000,
        handlers = {
          cursor = false,
          gitsigns = true,
          diagnostic = true,
        },
        marks = {
          Hint = { text = { "💡" } },
          Warn = { text = { "⚡" } },
          Error = { text = { "■", color = "red" } },
          GitAdd = { color = "green" },
          GitChange = { color = "orange" },
          GitDelete = { color = "red" },
        },
      }
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
