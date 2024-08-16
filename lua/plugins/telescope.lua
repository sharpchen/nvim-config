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
        zoxide = {
          prompt_title = '[ Walking on the shoulders of TJ ]',
          mappings = {
            default = {
              after_action = function(selection)
                print('Update to (' .. selection.z_score .. ') ' .. selection.path)
              end,
            },
            ['<C-s>'] = {
              before_action = function(selection)
                print('before C-s')
              end,
              action = function(selection)
                vim.cmd.edit(selection.path)
              end,
            },
            -- Opens the selected entry in a new split
            ['<C-q>'] = { action = require('telescope._extensions.zoxide.utils').create_basic_command('split') },
          },
        },
      },
      defaults = {
        -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
    })

    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('zoxide')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({ cwd = vim.uv.cwd() })
    end, { desc = 'find in all files in project' })
    vim.keymap.set('n', '<leader>fpf', builtin.git_files, { desc = 'find in all tracked files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find in content' })
    vim.keymap.set('n', '<leader>fc', function()
      local config = vim.uv.os_uname().sysname == 'Windows_NT' and '~/AppData/Local/nvim' or '~/.config/nvim'
      builtin.find_files({ cwd = config })
    end, { desc = 'find nvim config file' })
  end,
}
