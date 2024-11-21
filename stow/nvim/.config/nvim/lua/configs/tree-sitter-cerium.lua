local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.cerium = {
  install_info = {
    url = "/home/yhya/Programming/tree-sitter-cerium",
    files = { "src/parser.c" },
  },

  filetype = "cerm",
}

vim.filetype.add {
  extension = {
    cerm = "cerium",
  },
}
