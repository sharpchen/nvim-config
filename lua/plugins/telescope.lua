return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_cursor({}),
        },
      },
      defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
    })
    require('telescope').load_extension('ui-select')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({ cwd = vim.uv.cwd() })
    end, { desc = 'find in all files in project' })
    vim.keymap.set('n', '<leader>fpf', builtin.git_files, { desc = 'find in all tracked files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find in content' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'find by buffer name' })
    vim.keymap.set('n', '<leader>fc', function()
      local config = vim.uv.os_uname().sysname == 'Windows_NT' and '~/AppData/Local/nvim' or '~/.config/nvim'
      builtin.find_files({ cwd = config })
    end, { desc = 'find nvim config file' })
  end,
}
