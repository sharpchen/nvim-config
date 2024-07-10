return {
  'rcarriga/nvim-notify',
  dependencies = {
    {
      'mrded/nvim-lsp-notify',
      config = function()
        require('lsp-notify').setup({
          notify = require('notify'),
        })
      end,
    },
  },
  config = function()
    require('notify').setup({
      timeout = 1000,
      top_down = false,
      render = 'wrapped-compact',
    })
    vim.notify = require('notify')
    -- local severity = {
    --   'error',
    --   'warn',
    --   'info',
    --   'hint',
    -- }
    -- vim.lsp.handlers['window/showMessage'] = function(_, method, params, _)
    --   vim.notify(method.message, severity[params.type])
    -- end
  end,
}
