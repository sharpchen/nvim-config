return {
  'akinsho/toggleterm.nvim',
  version = '*',
  init = function() end,
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
      float_opts = {
        border = 'rounded',
      },
    })
    -- vim.keymap.set({ 'n', 'i', 't' }, [[<C-\>]], '<cmd>ToggleTerm dir=getcwd()<CR>')
    --
    -- vim.keymap.set({ 'n', 'i', 't' }, [[<M-\>]], function()
    --   local path = require('plenary.path'):new({ vim.api.nvim_buf_get_name(0) }):parent().filename
    --   vim.cmd('ToggleTerm')
    --   vim.cmd(('TermExec cmd="cd %s"'):format(path))
    -- end)
  end,
}
