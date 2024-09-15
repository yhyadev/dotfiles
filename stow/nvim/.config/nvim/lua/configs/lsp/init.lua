local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ocamllsp.setup({})
lspconfig.zls.setup({})
lspconfig.clangd.setup({})
lspconfig.cmake.setup({})
lspconfig.ts_ls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.gopls.setup({})
lspconfig.svelte.setup({})
lspconfig.pyright.setup({})
lspconfig.astro.setup({})
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})
lspconfig.emmet_language_server.setup({
    filetypes = { "astro", "svelte", "typescriptreact", "javascriptreact", "html", "css", "scss", "sass" },
})
lspconfig.html.setup({
    capabilities = capabilities,
})
lspconfig.cssls.setup({
    capabilities = capabilities,
})
lspconfig.intelephense.setup({
    capabilities = capabilities,
})

require("configs.lsp.mason")
require("configs.lsp.null-ls")
