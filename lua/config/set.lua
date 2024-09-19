local colo = { 'Eva-Dark', 'Eva-Light' }
vim.cmd(('colo %s'):format(colo[math.random(1, #colo)]))

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
vim.opt.guicursor =
  'n-v-sm:block-blinkwait700-blinkoff400-blinkon250-Cursor,ci-ve:ver25,r-cr-o:hor20,i-c:ver100-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
-- vim.opt.colorcolumn = '80'

-- render listchars on colorcolumn loaded
vim.opt.showmode = false
local listchars = [[nbsp:␣,eol:↵,space:·,tab:» ]]
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

vim.diagnostic.config({
  virtual_text = {
    prefix = ' ■ ', -- Could be '●', '▎', 'x', '■', , 
  },
  update_in_insert = true,
  underline = true,
  float = { border = 'rounded' },
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  callback = function()
    local from = vim.uv.cwd()
    ---@type string
    local target
    local args = vim.fn.argv()
    for _, arg in ipairs(type(args) == 'table' and args or {}) do
      if vim.fn.isdirectory(arg) == 1 then
        target = vim.fn.fnamemodify(from .. arg:sub(1, 1) == '/' and '' or '/' .. arg, ':p')
        if target:sub(1, 1) == '/' then
          target = target:sub(2)
        end
        break
      end
    end
    if target == nil then
      return
    end
    vim.cmd(string.format(':cd %s', target))
    vim.notify(string.format('cd to %s', target))
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('c')
    vim.opt_local.formatoptions:remove('r')
    vim.opt_local.formatoptions:remove('o')
  end,
})

vim.filetype.add({
  extension = {
    axaml = 'axaml',
    xaml = 'xaml',
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'help', 'man' },
  command = 'wincmd H',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'json',
  callback = function()
    -- Scan the file to find comments outside of strings
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      -- Remove everything within quotes (basic handling of strings)
      local without_string = line:gsub('".-"', '')
      -- Check for line or block comments
      if without_string:match('%/%/') or without_string:match('%/%*') then
        vim.bo.filetype = 'jsonc'
        break
      end
    end
  end,
  desc = 'detect JSONC',
})
