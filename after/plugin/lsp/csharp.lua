require('lsp-zero').extend_lspconfig()

require('lspconfig').csharp_ls.setup({
  handlers = {
    ['textDocument/definition'] = require('csharpls_extended').handler,
    ['textDocument/typeDefinition'] = require('csharpls_extended').handler,
  },
  cmd = { 'csharpls' },
  -- rest of your settings
})
