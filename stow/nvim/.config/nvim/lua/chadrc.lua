-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

  transparency = true,

  hl_add = {
    ["@constant.zig"] = { fg = "orange" },
    ["@lsp.type.enumMember.zig"] = { fg = "orange" },
    ["@punctuation.delimiter.zig"] = { fg = "light_grey" },
    ["@operator.zig"] = { fg = "cyan" },
  },
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "round",
  },

  nvdash = {
    load_on_startup = true,
  },
}

return M