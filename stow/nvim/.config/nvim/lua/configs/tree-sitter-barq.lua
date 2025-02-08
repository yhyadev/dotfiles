local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.barq = {
  install_info = {
    url = "/home/yhya/Programming/tree-sitter-barq",
    files = { "src/parser.c" },
  },

  filetype = "bq",
}

vim.filetype.add {
  extension = {
    bq = "barq",
  },
}
