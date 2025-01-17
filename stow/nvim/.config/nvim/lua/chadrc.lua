-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  hl_add = {
    ["@constant.zig"] = { fg = "orange" },
    ["@lsp.type.enumMember.zig"] = { fg = "orange" },
    ["@punctuation.delimiter.zig"] = { fg = "light_grey" },
    ["@operator.zig"] = { fg = "cyan" },
  },

  changed_themes = {
    tokyonight = {
      base_16 = {
        base00 = "#11121d",
        base01 = "#1b1c27",
        base02 = "#21222d",
        base03 = "#282934",
        base04 = "#30313c",
        base05 = "#abb2bf",
        base06 = "#b2b9c6",
      },

      base_30 = {
        white = "#A0A8CD",
        darker_black = "#0c0d18",
        black = "#11121D",
        black2 = "#171823",
        one_bg = "#1d1e29",
        one_bg2 = "#252631",
        one_bg3 = "#252631",
        grey = "#474853",
        grey_fg = "#474853",
        grey_fg2 = "#4e4f5a",
        light_grey = "#545560",
        statusline_bg = "#161722",
        lightbg = "#2a2b36",
      },
    },
  },
}

M.ui = {
  statusline = {
    separator_style = "round",
  },

  cmp = {
    style = "atom",
  },
}

M.nvdash = {
  header = {
    "           ▄ ▄                   ",
    "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    "                                 ",
  },
}

return M
