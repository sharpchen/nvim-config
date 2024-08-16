return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.powershell = {
      install_info = {
        url = 'https://github.com/airbus-cert/tree-sitter-powershell/',
        files = { 'src/parser.c', 'src/scanner.c' },
        branch = 'main',
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = 'ps1',
    }
    parser_config.fsharp = {
      install_info = {
        url = 'https://github.com/ionide/tree-sitter-fsharp',
        branch = 'main',
        files = { 'src/scanner.c', 'src/parser.c' },
      },
      requires_generate_from_grammar = false,
      filetype = 'fsharp',
    }
    --[[ parser_config.csharp = {
      install_info = {
        url = 'https://github.com/tree-sitter/tree-sitter-c-sharp',
        branch = 'master',
        files = { 'src/scanner.c', 'src/parser.c' },
      },
      requires_generate_from_grammar = false,
      filetype = 'cs',
    } ]]
    vim.treesitter.language.register('xml', { 'axaml', 'xaml' })

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
        'typescript',
        'javascript',
        'jsdoc',
        'html',
        'json',
        'jsonc',
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
        'regex',
        'nix',
        'markdown',
        'markdown_inline',
      },
      sync_install = false,
      highlight = { enable = true, additional_vim_regex_highlighting = true },
      indent = { enable = true },
    })
  end,
}
