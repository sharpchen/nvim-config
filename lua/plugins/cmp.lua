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
local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
    if kind1 == 'Variable' and entry1:get_completion_item().label:match('%w*=') then
      kind1 = 'Parameter'
    end
    if kind2 == 'Variable' and entry2:get_completion_item().label:match('%w*=') then
      kind2 = 'Parameter'
    end

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end
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
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
          nvim_lua = '[Lua]',
          latex_symbols = '[LaTeX]',
        })[entry.source.name]
        vim_item.menu = kind:lower()
        return vim_item
      end,
    },
    sorting = {
      comparators = {
        lspkind_comparator({
          kind_priority = {
            Parameter = 14,
            Variable = 12,
            Field = 11,
            Property = 11,
            Constant = 10,
            Enum = 10,
            EnumMember = 10,
            Event = 10,
            Function = 10,
            Method = 10,
            Operator = 10,
            Reference = 10,
            Struct = 10,
            File = 8,
            Folder = 8,
            Class = 5,
            Color = 5,
            Module = 5,
            Keyword = 2,
            Constructor = 1,
            Interface = 1,
            Snippet = 0,
            Text = 1,
            TypeParameter = 1,
            Unit = 1,
            Value = 1,
          },
        }),
        label_comparator,
      },
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
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
    },
  },
  config = function()
    regular_setup()
    setup_cmd()
  end,
}
