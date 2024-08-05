local function set_windows_clipboard()
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

if vim.uv.os_uname().release:find('WSL2') ~= nil then
  set_windows_clipboard()
end
