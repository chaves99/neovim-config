return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "javascript",
            "lua",
            "vim",
            "markdown",
            "markdown",
            "angular",
            "java",
            "json",
            "typescript",
            "python",
            "html",
            "css",
            "ninja",
            "rst",
        },

        sync_install = false,

        auto_install = true,

        highlight = {
            enable = true,
        }
    }
}
