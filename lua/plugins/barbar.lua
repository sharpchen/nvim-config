return
{
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false

        vim.keymap.set('n', '<A-c>', ':BufferClose<CR>', { desc = 'close current buffer' })
        vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>', { desc = 'move to previous buffer' })
        vim.keymap.set('n', '<A-.>', ':BufferNext<CR>', { desc = 'move to next buffer' })
        vim.keymap.set('n', '<A-a>', function()
            vim.cmd(':BufferCloseAllButCurrent')
        end, { desc = 'close all buffers' })
    end,
    opts = {
        animation = true,
        insert_at_start = true,
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
