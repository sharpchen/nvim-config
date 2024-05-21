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
    'nvim-treesitter/playground',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    { 'VonHeikemen/lsp-zero.nvim',           branch = 'v3.x' },
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
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
    { dir = '~/desktop/Eva-Theme.nvim',      lazy = false },
    -- indent line match
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    -- match same occurrences
    'RRethy/vim-illuminate',
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        lazy = false
    },
    'lewis6991/gitsigns.nvim',
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
                    { desc = "toggle outline" })

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
    },
    'onsails/lspkind.nvim'
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
