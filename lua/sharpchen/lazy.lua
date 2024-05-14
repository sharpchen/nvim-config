local plugins = {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    }
    ,
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", 'cpp', 'css', 'scss', 'asm', 'bash', 'diff', "lua", 'luap', 'luadoc', "vim", "vimdoc", "rust", "c_sharp", "typescript", "javascript", 'jsdoc', "html", 'json', 'xml', 'java', 'kotlin', 'haskell', 'sql', 'python', 'csv', 'vue', 'dockerfile', 'gitignore', 'gitcommit', 'gitattributes', 'git_config', 'go', 'query' },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'nvim-treesitter/playground'
    },
    'mbbill/undotree',
    'tpope/vim-fugitive',
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lua",
    'nvim-treesitter/nvim-treesitter-context',
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        }
    },
    'rktjmp/lush.nvim',
    { dir = '/home/sharpchen/desktop/lush_test', lazy = true },
    -- indent line match
    { "lukas-reineke/indent-blankline.nvim",     main = "ibl", opts = {} },
    -- match same occurrences
    'RRethy/vim-illuminate',
    -- explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                -- on_attach = function(bufnr)
                --     local api = require "nvim-tree.api"
                --
                --     local function opts(desc)
                --         return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                --     end
                --
                --     -- default mappings
                --     api.config.mappings.default_on_attach(bufnr)
                --
                --     -- custom mappings
                --     vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
                --     vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
                -- end
                view = {
                    side = 'right'
                }
            }
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end

    },
    {
        {
            "kdheepak/lazygit.nvim",
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            -- optional for floating window border decoration
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            -- setting the keybinding for LazyGit with 'keys' is recommended in
            -- order to load the plugin when the command is run for the first time
            keys = {
                { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            }
        }
    },
    {
        'norcalli/nvim-colorizer.lua'
    },
    {
        'akinsho/bufferline.nvim',
        config = function()
            require('bufferline').setup()
        end
    },
    {
        {
            "hedyhli/outline.nvim",
            config = function()
                -- Example mapping to toggle outline
                vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                    { desc = "Toggle Outline" })

                require("outline").setup {
                    -- Your setup opts here (leave empty to use defaults)
                }
            end,
        },
    },
    {
        {
            'rmagatti/goto-preview',
            config = function()
                require('goto-preview').setup {}
            end
        }
    },
    {
        { 'akinsho/toggleterm.nvim', version = "*", opts = {} },
    },
    {
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    }
}

local opts = {

}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)
