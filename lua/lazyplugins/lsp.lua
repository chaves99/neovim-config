return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()
        --local capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require('mason').setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }

        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = {
                "lua_ls",
                "angularls",
                "pyright",
                "ts_ls",
                "html",
                "cssls",
                "sqlls",
            }
        }

        local lspconfig = require("lspconfig")

        -- lspconfig.pyright.setup {
        --     capabilities = capabilities,
        -- }

        -- lspconfig.lua_ls.setup {
        --     capabilities = capabilities,
        -- }
        --
        -- lspconfig.angularls.setup {
        --     capabilities = capabilities,
        -- }
        --
        -- lspconfig.ts_ls.setup {
        --     capabilities = capabilities,
        -- }
        --
        -- lspconfig.html.setup {
        --     capabilities = capabilities,
        -- }
        --
        -- lspconfig.cssls.setup {
        --     capabilities = capabilities,
        -- }
        --
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "none",
                header = "",
                prefix = "",
            },
        })
    end
}
