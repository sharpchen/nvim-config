-- All options that can be passed to `user_default_options` in setup() can be passed here
-- Similar for other functions
-- Attach to buffer
-- require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
-- Detach from buffer
-- require("colorizer").detach_from_buffer(0, { mode = "virtualtext", css = true })
require('colorizer').setup({
    -- filetypes = { 'css', 'js', 'ts' },
    user_default_options = {
        names = false,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = 'virtualtext',
        tailwind = true,
        always_update = true
    }
})
