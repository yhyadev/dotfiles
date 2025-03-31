-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "ts_ls", "pyright", "clangd", "ocamllsp", "hls" }

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.zls.setup {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
}

lspconfig.rust_analyzer.setup {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
}

vim.diagnostic.config({
    severity_sort = true,
    virtual_text = false,
    virtual_lines = true,
})
