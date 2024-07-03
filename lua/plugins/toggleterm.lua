return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local priority = { 'nu', 'bash', 'pwsh', 'zsh' }
    local found_shell
    for _, shell in ipairs(priority) do
      if vim.fn.executable(shell) == 1 then
        found_shell = shell
        break
      end
    end
    require('toggleterm').setup({
      -- size = 10,
      start_in_insert = true,
      direction = 'horizontal',
      shell = found_shell,
      -- float_opts = {
      --   border = 'curved',
      --   width = math.ceil(vim.o.columns * 0.8),
      --   height = math.ceil(vim.o.columns * 0.2),
      -- },
    })
    vim.keymap.set('n', '<leader>`', ':ToggleTerm<CR>', { desc = 'toggle terminal', silent = true })
  end,
}
