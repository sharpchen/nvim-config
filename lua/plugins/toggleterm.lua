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
      start_in_insert = true,
      open_mapping = [[<C-\>]],
      shell = found_shell,
      direction = 'float',
    })
  end,
}
