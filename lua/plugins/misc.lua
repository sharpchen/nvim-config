return {
  'nvim-treesitter/playground',
  'neovim/nvim-lspconfig',
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
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
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {},
  },
  'rebelot/heirline.nvim',
  'j-hui/fidget.nvim',
}
