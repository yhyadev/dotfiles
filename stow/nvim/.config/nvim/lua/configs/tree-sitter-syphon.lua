local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.syphon = {
  install_info = {
    url = "/home/yhya/Programming/tree-sitter-syphon",
    files = { "src/parser.c" },
  },

  filetype = "sy",
}

vim.filetype.add {
  extension = {
    sy = "syphon",
  },

  pattern = {
    [".*"] = {
      function(_, bufnr)
        local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

        if vim.regex([[^#!/usr/bin/env -S syphon run]]):match_str(content) ~= nil then
          return "syphon"
        end
      end,
    },
  },
}
