vim.cmd('colo Eva-Dark')

-- line number
vim.opt.nu = true

-- relative line number
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- vim.opt.colorcolumn = '80'

-- vim.opt.list = true
-- vim.opt.listchars:append('space:⋅')

vim.opt.showmode = false

vim.o.list = true
vim.o.listchars = 'nbsp:␣,eol:↵,space:·'
vim.cmd([[2match WhiteSpaceBol /^ \+/]])
vim.cmd('match WhiteSpaceMol / /')
vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
    fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
})
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
            fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg)
        })
    end
})
