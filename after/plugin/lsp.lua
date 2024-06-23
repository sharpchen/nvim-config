local lsp_zero = require('lsp-zero')

vim.diagnostic.config({ update_in_insert = true })

-- event when attach to current file
lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end)

local servers = {
    ['vtsls'] = { 'typescript' },
    ['rust_analyzer'] = { 'rust' },
    ['csharp_ls'] = { 'csharp' },
    ['lua_ls'] = { 'lua' },
    ['ast_grep'] = { 'c' },
    ['bashls'] = { 'sh', 'bashrc', 'zshrc' }
    -- ['harper_ls'] = { '*' }
}
-- `format_on_save` should run only once, before the language servers are active.
-- format on save for servers
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = servers
})
-- format remap for servers
lsp_zero.format_mapping('<leader>k', {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = servers
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

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
-- assign icons for inline error message in the left of number column
lsp_zero.set_sign_icons({
    error = '!',
    warn = '?',
    hint = '@',
    info = '~'
})

-- config mason to manage language servers
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "->",
            package_uninstalled = "×"
        }
    }
})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = {
        'vtsls',
        'rust_analyzer',
        'lua_ls',
        'ast_grep',
        'bashls',
        'jsonls',
        'powershell_es',
        'lemminx',
        'yamlls',
        'volar',
        'tailwindcss',
        'html',
        'unocss',
        vim.loop.os_uname().sysname == "Windows_NT" and 'csharp_ls' or 'omnisharp'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})
