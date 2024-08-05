return {
  'numToStr/Comment.nvim',
  init = function()
    vim.keymap.del({ 'n', 'x', 'o' }, 'gc')
    vim.keymap.del('n', 'gcc')
  end,
  config = function()
    require('Comment').setup()
  end,
}
