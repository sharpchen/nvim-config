return {
  'sharpchen/Eva-Theme.nvim',
  lazy = false,
  priority = 1000,
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
      override_highlight = {
        ['@lsp.type.enumMember'] = function(v)
          return {
            fg = require('Eva-Theme.utils').is_dark(v) and require('Eva-Theme.palette').dark_base.digit
              or require('Eva-Theme.palette').light_base.digit,
            bold = true,
          }
        end,
      },
    })
  end,
}
