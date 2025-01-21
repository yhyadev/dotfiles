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
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "NvChad/base46",
    branch = "v3.0",
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
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
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
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {},
  },
}
