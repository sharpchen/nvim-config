vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    { desc = 'go to preview', noremap = true })
