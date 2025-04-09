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
}

M.ui = {
  statusline = {
    separator_style = "round",
    modules = {
      mode = function()
        local utils = require "nvchad.stl.utils"
        local config = require("nvconfig").ui.statusline

        local sep_icons = utils.separators
        local sep_style = config.separator_style
        local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

        local sep_l = separators["left"]
        local sep_r = separators["right"]

        if not utils.is_activewin() then
          return ""
        end

        local modes = utils.modes

        local m = vim.api.nvim_get_mode().mode

        local current_mode = "%#St_" .. modes[m][2] .. "Mode#" .. " " .. modes[m][1] .. " "
        local mode_sep_l = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_l
        local mode_sep_r = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r

        return mode_sep_l .. current_mode .. mode_sep_r
      end,

      cursor = function ()
        local utils = require "nvchad.stl.utils"
        local config = require("nvconfig").ui.statusline

        local sep_icons = utils.separators
        local sep_style = config.separator_style
        local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

        local sep_l = separators["left"]
        local sep_r = separators["right"]

        return "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %l/%c %#St_pos_sep#" .. sep_r
      end,
    },
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
