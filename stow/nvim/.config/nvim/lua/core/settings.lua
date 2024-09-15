local opt = vim.opt
local g = vim.g
local o = vim.o

opt.termguicolors = true

-- Tab/Indent
opt.smarttab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true


-- Show Line Number
opt.number = true

-- Remove The Tilde (~) At The End Of Buffer
opt.fillchars = { eob = " " }

-- Enable Wrap (Because Iam Using Mobile)
opt.wrap = true

-- Enable Clipboard Copy/Paste
opt.clipboard = "unnamedplus"

-- Remove Highlight While Searching (/)
vim.opt.hlsearch = false

-- Use c syntax for .h instead of cpp
g.c_syntax_for_h = true

-- Zig Standard Library recognition for termux users (temporary until Zig maintainers solves issue "#14146")
if os.getenv("TERMUX_VERSION") then
    g.zig_std_dir = "/data/data/com.termux/files/usr/lib/zig/lib/std"
end
