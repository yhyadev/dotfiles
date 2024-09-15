require("nvim-treesitter.configs").setup({
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	autopairs = { enable = true },
	indent = { enable = true, disable = { "python", "css" } },
	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true,
		},
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
	},
})

require("configs.tree-sitter-syphon")
