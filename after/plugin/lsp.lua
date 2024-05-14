local lsp_zero = require('lsp-zero')
-- event when attach to current file
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- don't add this function in the `on_attach` callback.
-- `format_on_save` should run only once, before the language servers are active.
local servers = {

    ['tsserver'] = { 'javascript', 'typescript' },
    ['rust_analyzer'] = { 'rust' },
    ['csharp_ls'] = { 'csharp' },
    ['lua_ls'] = { 'lua' }
}
-- format on save for servers
lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = servers
})
-- format remap for servers
lsp_zero.format_mapping('<leader>f', {
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = servers
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

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
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    -- confirm completion using Enter and Tab
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.confirm({ select = false }),
    }),
})
-- assign icons for inline error message in the left of number column
lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

-- config mason to manage language servers
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'rust_analyzer', 'csharp_ls', 'quick_lint_js' },
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
