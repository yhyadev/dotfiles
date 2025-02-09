local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    zig = { "zigfmt" },
    rust = { "rustfmt" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    python = { "black" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
