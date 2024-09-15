local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		formatting.black,
        formatting.clang_format,
		formatting.golines,
		formatting.prettier,
		formatting.rustfmt,
		formatting.stylua,
	},
})
