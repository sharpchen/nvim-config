local cmp = require('cmp')

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

cmp.setup({
    -- add source to intellisense nvim api for lua
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' }
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    -- preselect first completion item
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    -- add border to completion list
    window = {
        completion = {
            border = 'solid',
        },
        documentation = {
            border = 'solid'
        },
    },
    -- confirm completion using Enter and Tab
    mapping = cmp.mapping.preset.insert({
        -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    }),

    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    }
})
