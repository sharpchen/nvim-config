local kind_icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = ' ',
  EnumMember = ' ',
  Constant = '',
  Struct = ' ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}
local function setup_cmd()
  local cmp = require('cmp')
  local keymap = {
    ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Down>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
    },
    ['<C-Up>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
  }
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(keymap),
    sources = {
      { name = 'buffer' },
      {
        name = 'spell',
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
          preselect_correct_word = true,
        },
      },
    },
  })
  -- `:` cmdline setup.
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(keymap),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

local function regular_setup()
  local cmp = require('cmp')
  cmp.setup({
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'nvim_lsp_signature_help' },
      {
        name = 'spell',
        option = {
          keep_all_entries = false,
          enable_in_context = function()
            return true
          end,
          preselect_correct_word = true,
        },
      },
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    preselect = 'item',
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    }),
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        ---@type string
        local kind = vim_item.kind
        vim_item.kind = kind_icons[vim_item.kind] .. ' '
        vim_item.menu = ({
          buffer = '[buf]',
          nvim_lsp = '[lsp]',
          luasnip = '[luasnip]',
          nvim_lua = '[lua]',
          latex_symbols = '[LaTeX]',
        })[entry.source.name]
        vim_item.menu = kind:lower()
        return vim_item
      end,
    },
    sorting = {
      comparators = {
        cmp.config.compare.exact,
        cmp.config.compare.recently_used,
        cmp.config.compare.length,
        cmp.config.compare.offset,
        cmp.config.compare.score,
        cmp.config.compare.kind,
      },
    },
    experimental = {
      ghost_text = true,
    },
    window = {
      completion = cmp.config.window.bordered(),--[[ {
        border = vim
          .iter({ '┌', '─', '┐', '│', '┘', '─', '└', '│' })
          :map(function(x)
            return { x, 'FloatBorder' }
          end)
          :totable(),
      }, ]]
      documentation = false,
    },
  })
end

return {
  'hrsh7th/nvim-cmp',
  version = false,
  branch = 'main',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'f3fora/cmp-spell',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
    },
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    regular_setup()
    setup_cmd()
  end,
}
