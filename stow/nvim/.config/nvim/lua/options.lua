require "nvchad.options"

local opt = vim.opt
local o = vim.o
local g = vim.g

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.smartindent = true

o.termguicolors = true

g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets"
