return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  config = function()
    local lsp_zero = require('lsp-zero')
    -- event when attach to current file
    lsp_zero.on_attach(function(_, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({ buffer = bufnr })
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end)

    local formatter_server_map = {
      ['rust_analyzer'] = { 'rust' },
      ['csharp_ls'] = { 'csharp' },
      ['ast_grep'] = { 'c' },
      ['bashls'] = { 'sh' },
      ['taplo'] = { 'toml' },
    }
    -- `format_on_save` should run only once, before the language servers are active.
    -- format on save for servers
    lsp_zero.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = formatter_server_map,
    })
    -- assign icons for inline error message in the left of number column
    lsp_zero.set_sign_icons({
      error = '',
      warn = '',
      hint = '',
      info = '',
    })
  end,
}
