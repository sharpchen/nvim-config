require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    -- Use a sub-list to run only the first available formatter
    javascript = { 'prettier' },
    typescript = { 'prettier' },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
})

-- if has any tool for current file, use the tool, esle use lsp to format
vim.keymap.set('n', '<leader>k', function()
  local conform = require('conform')
  local formatter = conform.formatters[vim.bo.filetype] or conform.formatters_by_ft[vim.bo.filetype]
  if formatter then
    conform.format({ bufnr = vim.api.nvim_get_current_buf() })
  else
    vim.lsp.buf.format({ async = false, timeout_ms = 500 })
  end
end, { desc = 'format current file' })
