local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

local servers = { "html", "cssls", "ts_ls", "pyright", "clangd", "ocamllsp", "hls", "zls", "rust_analyzer" }

vim.lsp.enable(servers)

vim.lsp.config("zls", {
  on_init = function() end,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
})

vim.lsp.config("rust_analyzer", {
  on_init = function() end,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
})

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = false,
  virtual_lines = true,
}
