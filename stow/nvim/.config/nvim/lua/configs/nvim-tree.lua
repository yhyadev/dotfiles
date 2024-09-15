require("nvim-tree").setup({
    view = {
        width = 25,
    },
   filters = {
        custom = {
            ".git",
            "node_modules",
        },
    },
})
