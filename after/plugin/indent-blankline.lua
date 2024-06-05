require('ibl').setup({
    indent = {
        char = '▏',
        smart_indent_cap = true,
        priority = 2,
        repeat_linebreak = true
    },
    scope = { enabled = true, show_exact_scope = false, show_start = false, show_end = false }
})
vim.o.list = true
vim.o.listchars = 'nbsp:␣,eol:↵,space:·'
