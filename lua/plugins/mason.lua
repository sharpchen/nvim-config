return {
  'williamboman/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'yioneko/nvim-vtsls',
    'Decodetalkers/csharpls-extended-lsp.nvim',
    'Hoffs/omnisharp-extended-lsp.nvim',
  },
  config = function()
    require('mason').setup()
    require('lsp-zero').extend_lspconfig()
    require('mason-lspconfig').setup({
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
          local lua_opts = require('lsp-zero').nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end,
        omnisharp = function()
          require('lspconfig').omnisharp.setup({
            handlers = {
              ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
              ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
              ['textDocument/references'] = require('omnisharp_extended').references_handler,
              ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
            },
          })
        end,
        taplo = function()
          require('lspconfig').taplo.setup({})
        end,
      },
    })
    require('mason-tool-installer').setup({
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
        -- 'csharp_ls',
        -- 'omnisharp',
        'stylua',
        'shfmt',
        'fsautocomplete',
        'markdownlint-cli2',
      },
    })

    require('lspconfig').nixd.setup({
      on_init = function(client)
        client.server_capabilities.semanticTokensProvider = nil
      end,
    })
  end,
}
