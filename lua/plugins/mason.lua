return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('lsp-zero').extend_lspconfig()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'vtsls',
        'rust_analyzer',
        'lua_ls',
        'ast_grep',
        'bashls',
        'jsonls',
        'powershell_es',
        'lemminx',
        'yamlls',
        'volar',
        'tailwindcss',
        'html',
        'unocss',
        'csharp_ls',
        'nil_ls',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
          local lua_opts = require('lsp-zero').nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
      },
    })
  end,
}