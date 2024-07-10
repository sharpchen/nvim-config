return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'davidmh/cspell.nvim',
  },
  config = function()
    require('null-ls').setup({
      sources = {
        -- require('cspell').diagnostics.with({
        --   diagnostics_postprocess = function(diagnostic)
        --     diagnostic.severity = vim.diagnostic.severity['HINT']
        --   end,
        -- }),
        -- require('cspell').code_actions,
      },
    })
  end,
}
