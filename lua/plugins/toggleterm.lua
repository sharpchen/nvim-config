return {
  'akinsho/toggleterm.nvim',
  version = '*',
  init = function() end,
  config = function()
    vim.o.shell = vim
      .iter({ 'bash', 'nu', 'pwsh', 'zsh' })
      :filter(function(x)
        return vim.fn.executable(x) == 1
      end)
      :peek()
    require('toggleterm').setup({
      start_in_insert = true,
      direction = 'float',
      float_opts = {
        border = 'rounded',
      },
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local rootTerm = Terminal:new({ count = 1 })
    local bufTerm = Terminal:new({ count = 5 })
    local bufPath = nil
    vim.keymap.set({ 'n', 'x', 't', 'v' }, '<C-\\>', function()
      rootTerm:toggle()
    end)
    vim.keymap.set({ 'n', 'x', 't', 'v' }, '<M-\\>', function()
      ---@type string
      local path = require('plenary.path'):new({ vim.api.nvim_buf_get_name(0) }):parent().filename
      if vim.fn.isdirectory(path) == 1 then
        local path_changed = path ~= bufPath
        bufPath = path_changed and path or bufPath
        if path_changed then
          if not bufTerm:is_open() then
            bufTerm:toggle()
            bufTerm:toggle()
          end
          if vim.o.shell == 'bash' then
            bufTerm:send({ ("cd '%s'; history -d $(history 1)"):format(path), 'clear; history -d $(history 1)' })
          else
            bufTerm:send({ ("cd '%s'"):format(path), vim.o.shell == 'pwsh' and 'cls' or 'clear' })
          end
        end
      end
      bufTerm:toggle()
    end)
    vim.api.nvim_create_autocmd({ 'TermEnter' }, {
      callback = function()
        for _, buffers in ipairs(vim.fn.getbufinfo()) do
          local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, 'filetype')
          if filetype == 'toggleterm' then
            vim.api.nvim_create_autocmd({ 'BufWriteCmd', 'FileWriteCmd', 'FileAppendCmd' }, {
              buffer = buffers.bufnr,
              command = 'q!',
            })
          end
        end
      end,
    })
  end,
}
