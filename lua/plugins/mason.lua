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
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    local function disable_semantic(client)
      client.server_capabilities.semanticTokensProvider = nil
    end
    require('mason').setup({ ui = { border = 'rounded' } })
    require('mason-lspconfig').setup({
      handlers = {
        function(server)
          require('lspconfig')[server].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          })
        end,
        lua_ls = function()
          require('lspconfig').lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                hint = {
                  enable = true,
                  paramName = 'Literal',
                  semicolon = 'Disable',
                },
                runtime = {
                  version = 'LuaJIT',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                },
              },
            },
          })
        end,
        csharp_ls = function()
          require('lspconfig').csharp_ls.setup({
            capabilities = lsp_capabilities,
            on_init = disable_semantic,
            handlers = {
              ['textDocument/definition'] = require('csharpls_extended').handler,
              ['textDocument/typeDefinition'] = require('csharpls_extended').handler,
            },
          })
        end,
        taplo = function()
          require('lspconfig').taplo.setup({
            capabilities = lsp_capabilities,
          })
        end,
        biome = function()
          require('lspconfig').biome.setup({
            capabilities = lsp_capabilities,
          })
        end,
        vtsls = function()
          require('lspconfig').vtsls.setup({
            settings = {
              typescript = {
                inlayHints = {
                  parameterNames = { enabled = 'literal' },
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  enumMemberValues = { enabled = true },
                },
              },
            },
          })
        end,
        harper_ls = function()
          require('lspconfig').harper_ls.setup({
            settings = {
              ['harper_ls'] = {
                linters = {
                  sentence_capitalization = false,
                },
              },
            },
          })
        end,
        lemminx = function()
          require('lspconfig').lemminx.setup({
            filetypes = { 'xml', 'axaml' },
          })
        end,
      },
    })
    require('lspconfig').nixd.setup({
      on_init = disable_semantic,
    })
    require('mason-tool-installer').setup({
      ensure_installed = {
        'vtsls',
        'biome',
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
        'stylua',
        'shfmt',
        'fsautocomplete',
        'markdownlint-cli2',
        'actionlint',
      },
    })
    -- vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
  end,
}
