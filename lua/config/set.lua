vim.cmd('colo Eva-Dark')

-- line number
vim.opt.nu = true

-- relative line number
vim.opt.rnu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- vim.opt.colorcolumn = '80'

-- vim.opt.list = true
-- vim.opt.listchars:append('space:⋅')

-- render listchars on colorcolumn loaded
vim.opt.showmode = false
local listchars = [[nbsp:␣,eol:↵,space:·,tab:  ]]
vim.o.list = true
vim.o.listchars = listchars
vim.cmd([[2match WhiteSpaceBol /^ \+/]])
vim.cmd('match WhiteSpaceMol / /')
vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
  fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg),
})
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.o.list = true
    vim.o.listchars = listchars
    vim.cmd([[2match WhiteSpaceBol /^ \+/]])
    vim.cmd('match WhiteSpaceMol / /')
    vim.api.nvim_set_hl(0, 'WhiteSpaceMol', {
      fg = string.format('#%x', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg),
    })
  end,
})

-- diagnostic popup when cursor stays
vim.o.updatetime = 250
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      -- border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = ' ■ ', -- Could be '●', '▎', 'x', '■', , 
  },
  update_in_insert = true,
  underline = true,
  float = { border = 'single' },
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    local from = vim.uv.cwd()
    local target
    local args = vim.fn.argv()
    for _, arg in ipairs(type(args) == 'table' and args or {}) do
      if vim.fn.isdirectory(arg) then
        target = vim.fn.fnamemodify(from .. arg:sub(1, 1) == '/' and '' or '/' .. arg, ':p')
        break
      end
    end
    vim.cmd(string.format(':cd %s', target))
    vim.notify(string.format('cd to %s', target))
  end,
})

local function set_clipboard()
  if vim.uv.os_uname().release:find('WSL2') == nil then
    return
  end
  local win32yank_path = vim.fn.expand('~/.local/bin/win32yank.exe')
  if vim.uv.fs_stat(win32yank_path) == nil then
    local install_script_path = '/tmp/install_win32yank.sh'
    local Task = require('plenary.job')
    local fetch = Task:new({
      command = 'wget',
      args = {
        '-nv',
        '-O',
        install_script_path,
        'https://raw.githubusercontent.com/sharpchen/clip-nvim/main/install.sh',
      },
      on_stderr = function(_, data)
        vim.notify(vim.fn.escape(data, '"') .. '"', vim.log.levels.TRACE)
      end,
      on_start = function()
        vim.notify('Downloading win32yank...', vim.log.levels.INFO)
      end,
      on_exit = function()
        vim.notify('win32yank downloaded.', vim.log.levels.INFO)
      end,
    })
    local chmod = Task:new({
      command = 'chmod',
      args = { '+x', install_script_path },
      on_stderr = function(_, val)
        vim.notify(vim.fn.escape(val, '"'), vim.log.levels.ERROR)
      end,
      on_stdout = function(_, val)
        vim.notify(vim.fn.escape(val, '"'), vim.log.levels.INFO)
      end,
    })
    local execute = Task:new({
      command = 'sh',
      args = { install_script_path },
      on_start = function()
        vim.notify('Installing win32yank...', vim.log.levels.INFO)
      end,
      on_exit = function()
        vim.notify('win32yank installed.', vim.log.levels.INFO)
      end,
    })
    chmod:and_then(execute)
    fetch:and_then(chmod)
    fetch:start()
  end
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = string.format('%s -i --crlf', win32yank_path),
      ['*'] = string.format('%s -i --crlf', win32yank_path),
    },
    paste = {
      ['+'] = string.format('%s -o --lf', win32yank_path),
      ['*'] = string.format('%s -o --lf', win32yank_path),
    },
    cache_enabled = true,
  }
end
set_clipboard()
