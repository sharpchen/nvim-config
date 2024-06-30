return {
    'NvChad/nvim-colorizer.lua',
    config = function()
        require('colorizer').setup({
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
    end
}
