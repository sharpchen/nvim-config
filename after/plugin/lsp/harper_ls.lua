local lspconfig = require('lspconfig')

lspconfig.harper_ls.setup({
  settings = {
    ['harper-ls'] = {
      userDictPath = '~/dict.txt',
      linters = {
        sentence_capitalization = false,
      },
    },
  },
})
