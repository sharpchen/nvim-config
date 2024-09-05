return {
  'nvim-treesitter/playground',
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- indent line match
  -- match same occurrences
  'RRethy/vim-illuminate',
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  'onsails/lspkind.nvim',
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  {
    'DaikyXendo/nvim-material-icon',
    config = function()
      require('nvim-web-devicons').setup({
        override_by_extension = {
          ['c++'] = {
            icon = '',
            color = '#0188d1',
            cterm_color = '32',
            name = 'cjj',
          },
          ['h++'] = {
            icon = '',
            color = '#0188d1',
            cterm_color = '32',
            name = 'hjj',
          },
        },
      })
    end,
  },
  'rebelot/heirline.nvim',
  'ThePrimeagen/vim-be-good',
  'LunarVim/bigfile.nvim',
}
