local heirline_utils = require('heirline.utils')
local conditions = require('heirline.conditions')
vim.cmd('set laststatus=3') -- share single statusline for all buffers
local colors = {
    normal = '',
    visual = '',
    insert = '',
    command = '',
    git_deleted = '',
    git_added = '',
    git_modified = '',
    warning = '',
    error = '',
    hint = '',
    info = ''
}


local function setup_colors()
    return {
        bright_bg = heirline_utils.get_highlight("Folded").bg,
        bright_fg = heirline_utils.get_highlight("Folded").fg,
        red = heirline_utils.get_highlight("DiagnosticError").fg,
        dark_red = heirline_utils.get_highlight("DiffDelete").bg,
        green = heirline_utils.get_highlight("String").fg,
        blue = heirline_utils.get_highlight("Function").fg,
        gray = heirline_utils.get_highlight("NonText").fg,
        orange = heirline_utils.get_highlight("Constant").fg,
        purple = heirline_utils.get_highlight("Statement").fg,
        cyan = heirline_utils.get_highlight("Special").fg,
        diag_warn = heirline_utils.get_highlight("DiagnosticWarn").fg,
        diag_error = heirline_utils.get_highlight("DiagnosticError").fg,
        diag_hint = heirline_utils.get_highlight("DiagnosticHint").fg,
        diag_info = heirline_utils.get_highlight("DiagnosticInfo").fg,
        git_del = heirline_utils.get_highlight("diffDeleted").fg,
        git_add = heirline_utils.get_highlight("diffAdded").fg,
        git_change = heirline_utils.get_highlight("diffChanged").fg,
    }
end

-- require("heirline").load_colors(setup_colors)
-- or pass it to config.opts.colors

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        heirline_utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})


local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = 'NORMAL',
            v = 'VISUAL',
            V = 'VLINE',
            i = 'INSERT',
            c = 'COMMAND'
        },
        mode_colors = {
            n = 'red',
            i = 'green',
            v = 'cyan',
            V = 'cyan',
            ['\22'] = 'cyan',
            c = 'orange',
            s = 'purple',
            S = 'purple',
            ['\19'] = 'purple',
            R = 'orange',
            r = 'orange',
            ['!'] = 'red',
            t = 'red',
        }
    },
    provider = function(self)
        return '%2(' .. self.mode_names[self.mode] .. '%)'
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bold = true, }
    end,
    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd('redrawstatus')
        end),
    },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and its children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then return '[No Name]' end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = heirline_utils.get_highlight('Directory').fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = '[+]',
        hl = { fg = 'green' },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = '',
        hl = { fg = 'orange' },
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a 'modifier'
-- component

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = 'cyan', bold = true, force = true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = heirline_utils.insert(FileNameBlock,
    FileIcon,
    heirline_utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<' }                               -- this means that the statusline is cut here when there's not enough space
)
local FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
    end
}
local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
        return (ftime > 0) and 'last modified: ' .. (os.date('%c', ftime))
    end
}

-- We're getting minimalist here!
local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    -- provider = '%7(%l/%3L%):%2c %P',
    provider = 'Ln %l, Col %c'
}
local LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },
    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return ' [' .. table.concat(names, ' ') .. ']'
    end,
    hl = { fg = 'green', bold = true },
}

local Git = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = 'orange' },
    { -- git branch name
        provider = function(self)
            return ' ' .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = '('
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ('+' .. count)
        end,
        hl = { fg = heirline_utils.get_highlight('Directory').fg },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ('-' .. count)
        end,
        hl = { fg = heirline_utils.get_highlight('Directory').fg },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ('~' .. count)
        end,
        hl = { fg = heirline_utils.get_highlight('Directory').fg },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ')',
    },
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = colors.blue },
}

local align = { provider = '%=' }
local sp = { provider = ' ' }
ViMode = heirline_utils.surround({ '', '' }, 'bright_bg', { ViMode })
require('heirline').setup({
    statusline = {
        ViMode, sp, Git, sp, align,
        FileNameBlock, sp, align,
        LSPActive, sp, Ruler, sp, HelpFileName, sp, FileSize,
    },
})
