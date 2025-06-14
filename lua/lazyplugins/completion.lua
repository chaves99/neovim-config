-- return {
--    'hrsh7th/cmp-nvim-lsp',
--    'hrsh7th/cmp-nvim-lsp',
--    'hrsh7th/cmp-buffer',
--    'hrsh7th/cmp-path',
--    'hrsh7th/cmp-cmdline',
--    'hrsh7th/nvim-cmp',
--}
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = false } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
