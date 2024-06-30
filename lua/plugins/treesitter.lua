return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                'c',
                'cpp',
                'css',
                'scss',
                'asm',
                'bash',
                'diff',
                'lua',
                'luap',
                'luadoc',
                'vim',
                'vimdoc',
                'rust',
                'c_sharp',
                'typescript',
                'javascript',
                'jsdoc',
                'html',
                'json',
                'xml',
                'java',
                'kotlin',
                'haskell',
                'sql',
                'python',
                'csv',
                'vue',
                'dockerfile',
                'gitignore',
                'gitcommit',
                'gitattributes',
                'git_config',
                'go',
                'query',
                'toml',
                'yaml',
            },
            sync_install = false,
            highlight = { enable = true, additional_vim_regex_highlighting = true },
            indent = { enable = true },
        })

        local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        treesitter_parser_config.powershell = {
            install_info = {
                url = 'https://github.com/airbus-cert/tree-sitter-powershell/',
                files = { 'src/parser.c', 'src/scanner.c' },
                branch = 'main',
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = 'ps1',
        }
    end
}
