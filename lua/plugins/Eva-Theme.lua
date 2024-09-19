return {
  'sharpchen/Eva-Theme.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local light = require('Eva-Theme.palette').light_base
    local dark = require('Eva-Theme.palette').dark_base
    require('Eva-Theme').setup({
      override_palette = {
        dark = {
          operator = dark.punctuation,
          -- background = '#14161B',
          typeparam = dark.type,
        },
        light = {
          operator = light.punctuation,
          typeparam = light.type,
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
