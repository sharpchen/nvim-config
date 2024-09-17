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
vim.keymap.set('n', '<leader>a', 'ggVG', { desc = 'select all text' })
vim.keymap.set('n', '<leader>i', '<cmd>Inspect<CR>', { desc = 'Inspect' })

vim.keymap.set('n', '<A-c>', '<cmd>bd<CR>', { desc = 'close current buffer' })
vim.keymap.set('n', '<A-,>', '<cmd>bp<CR>', { desc = 'move to previous buffer' })
vim.keymap.set('n', '<A-.>', '<cmd>bn<CR>', { desc = 'move to next buffer' })
vim.keymap.set('n', '<A-a>', '<cmd>bufdo bd<CR>', { desc = 'close all buffers' })

vim.keymap.set('n', '0', '^', { noremap = true, silent = true })
vim.keymap.set('n', '^', '0', { noremap = true, silent = true })

if vim.uv.os_uname().sysname == 'Linux' then
  vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    local init_bufnr = vim.fn.bufnr('#')
    vim.keymap.set('n', '<C-n>', function()
      if vim.fn.line('.') == vim.fn.line('$') then
        vim.notify('E553: No more items', vim.log.levels.ERROR)
        return
      end
      vim.cmd('wincmd p') -- jump to current displayed file
      vim.cmd(
        (vim.fn.bufnr('%') ~= init_bufnr and vim.bo.filetype ~= 'qf')
            and ('bd | wincmd p | cn | res %d'):format(
              math.floor(
                (vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 0 and 0 or 1) - (vim.o.tabline == '' and 0 or 1))
                    / 3
                    * 2
                  + 0.5
              ) - 1
            )
          or 'cn'
      )
      vim.cmd('execute "normal! zz"')
      if vim.bo.filetype ~= 'qf' then
        vim.cmd('wincmd p')
      end
    end, opts)

    vim.keymap.set('n', '<C-p>', function()
      if vim.fn.line('.') == 1 then
        vim.notify('E553: No more items', vim.log.levels.ERROR)
        return
      end
      vim.cmd('wincmd p') -- jump to current displayed file
      vim.cmd(
        (vim.fn.bufnr('%') ~= init_bufnr and vim.bo.filetype ~= 'qf')
            and ('bd | wincmd p | cN | res %d'):format(
              math.floor(
                (vim.o.lines - vim.o.cmdheight - (vim.o.laststatus == 0 and 0 or 1) - (vim.o.tabline == '' and 0 or 1))
                    / 3
                    * 2
                  + 0.5
              ) - 1
            )
          or 'cN'
      )
      vim.cmd('execute "normal! zz"')
      if vim.bo.filetype ~= 'qf' then
        vim.cmd('wincmd p')
      end
    end, opts)
  end,
})
