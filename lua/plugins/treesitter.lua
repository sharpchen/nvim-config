return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')
    require('nvim-treesitter.install').prefer_git = true
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.fsharp = {
      install_info = {
        url = 'https://github.com/ionide/tree-sitter-fsharp',
        branch = 'main',
        files = { 'src/scanner.c', 'src/parser.c' },
      },
      requires_generate_from_grammar = false,
      filetype = 'fsharp',
    }
    vim.treesitter.language.register('xml', { 'axaml', 'xaml' })
    configs.setup({
      ensure_installed = {
        'c',
        'cpp',
        'c_sharp',
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
        'powershell',
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
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'tnn', -- set to `false` to disable one of the mappints
          node_incremental = 'trn',
          scope_incremental = 'trc',
          node_decremental = 'trm',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            -- You can also use captures from other query groups like `locals.scm`
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
      },
    })
  end,
}
