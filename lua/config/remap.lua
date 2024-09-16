vim.g.mapleader = ' '

-- switch back to explorer
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- move selected lines up/down
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<M-Down>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<M-Up>', ":m '<-2<CR>gv=gv", { silent = true })

-- move current line up/down
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { silent = true })

vim.keymap.set('i', '<M-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<M-k>', '<Esc>:m .-2<CR>==gi', { silent = true })
vim.keymap.set('i', '<M-Down>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<M-Up>', '<Esc>:m .-2<CR>==gi', { silent = true })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'join next line with still cursor' })

-- jump half page up/down
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- keep occurrence center when jumping between search results
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- avoid replacing selected text overwrites previous copy
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'pasting without overwriting copy' })

-- copy to system clipboard
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'copy to system clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'copy to system clipboard' })

-- deleting without overwriting last clipboard
vim.keymap.set('n', '<leader>d', '"_d', { desc = 'deleting without overwriting clipboard' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'deleting without overwriting clipboard' })

-- switch to another file in the system using tmux
-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- replacing all occurrence of current word cursor is on by input text in command bar file-wide
vim.keymap.set(
  'n',
  '<leader>s',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'replace all occurrence of current word' }
)

vim.keymap.set('n', '<leader>/', ':set noignorecase<CR>/', { desc = 'case sensitive search' })
vim.keymap.set('n', '/', ':set ignorecase<CR>/', { desc = 'case insensitive search' })
-- vim.keymap.set('n', '\\', ':%s/', { desc = 'replace occurrence in current file' })
-- vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { desc = 'show code action' })
vim.keymap.set('n', '<leader>a', 'ggVG', { desc = 'select all text' })
vim.keymap.set('n', '<leader>x', 'Vx', { desc = 'cut current line' })
vim.keymap.set('n', '<leader>i', '<cmd>Inspect<CR>', { desc = 'Inspect' })

vim.keymap.set('n', '<A-c>', '<cmd>bd<CR>', { desc = 'close current buffer' })
vim.keymap.set('n', '<A-,>', '<cmd>bp<CR>', { desc = 'move to previous buffer' })
vim.keymap.set('n', '<A-.>', '<cmd>bn<CR>', { desc = 'move to next buffer' })
vim.keymap.set('n', '<A-a>', '<cmd>bufdo bd<CR>', { desc = 'close all buffers' })

vim.keymap.set('n', '0', '^', { noremap = true, silent = true })
vim.keymap.set('n', '^', '0', { noremap = true, silent = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', '<C-n>', '<cmd>cn | wincmd p<CR>', opts)
    vim.keymap.set('n', '<C-p>', '<cmd>cN | wincmd p<CR>', opts)
  end,
})
