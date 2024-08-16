return {
  'folke/which-key.nvim',
  -- enabled = false,
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  opts = {
    win = {
      border = 'rounded',
    },
  },
}
