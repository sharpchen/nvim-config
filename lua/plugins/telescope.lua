return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({ cwd = vim.uv.cwd() })
    end, { desc = 'find in all files in project' })
    vim.keymap.set('n', '<leader>fpf', builtin.git_files, { desc = 'find in all tracked files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find in content' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'find by buffer name' })
    vim.keymap.set('n', '<leader>fc', function()
      local cwd = vim.uv.os_uname() == 'Windows_NT' and '~/AppData/Local/nvim' or '~/.config/nvim'
      builtin.find_files({ cwd = cwd })
    end, { desc = 'find nvim config file' })
  end,
}
