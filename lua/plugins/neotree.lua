return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false,
    config = function()
        require('neo-tree').setup({
            window = {
                position = 'right'
            },
            filesystem = {
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                }
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(_)
                        vim.opt.relativenumber = true
                    end,
                }
            }
        })

        vim.keymap.set('n', '<leader>pv', ':Neotree toggle current reveal_force_cwd<CR>',
            { desc = 'neo-tree go back to project view' })

        vim.keymap.set('n', '<leader>n', ':Neotree float git_status<CR>', { desc = 'show floating neo-tree' })

        vim.keymap.set('n', '<leader>e', ':Neotree action=focus<CR>', { desc = 'focus neo-tree' })

        vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>', { desc = 'toggle neo-tree' })

        vim.api.nvim_create_autocmd('BufEnter', {
            callback = function()
                vim.cmd('Neotree action=close')
            end
        })
    end
}
