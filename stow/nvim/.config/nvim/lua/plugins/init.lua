return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "zig",
        "rust",
        "c",
      },
    },

    config = function()
      require "configs.treesitter"
    end,
  },

  {
    "NMAC427/guess-indent.nvim",
    event = "BufEnter",
    opts = {},
  },

  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {},
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = {
      sources = {
        { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
    },
  },

  {
    "NvChad/timerly",
    cmd = "TimerlyToggle",
  },
}
