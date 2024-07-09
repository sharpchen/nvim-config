return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    require('lint').linters_by_ft = {
      markdown = { 'markdownlint-cli2' },
    }
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged', 'TextChangedI' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
