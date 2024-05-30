local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = { "c", 'cpp', 'css', 'scss', 'asm', 'bash', 'diff', "lua", 'luap', 'luadoc', "vim", "vimdoc", "rust", "c_sharp", "typescript", "javascript", 'jsdoc', "html", 'json', 'xml', 'java', 'kotlin', 'haskell', 'sql', 'python', 'csv', 'vue', 'dockerfile', 'gitignore', 'gitcommit', 'gitattributes', 'git_config', 'go', 'query', 'toml', 'yaml', },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
