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
