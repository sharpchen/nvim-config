return {
  'nvim-treesitter/playground',
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'sharpchen/Eva-Theme.nvim',
    lazy = false,
    priority = 1000,
    event = 'VimEnter',
    config = function()
      require('Eva-Theme').setup({
        override_palette = {
          dark = {
            operator = require('Eva-Theme.utils').lighten(require('Eva-Theme.palette').dark_base.operator, 20),
            background = '#14161B',
            typeparam = require('Eva-Theme.palette').dark_base.type,
          },
          light = {
            operator = require('Eva-Theme.utils').darken(require('Eva-Theme.palette').light_base.operator, 20),
            typeparam = require('Eva-Theme.palette').light_base.type,
          },
        },
      })
    end,
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
  'NvChad/nvim-colorizer.lua',
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  'DaikyXendo/nvim-material-icon',
  'rebelot/heirline.nvim',
}
