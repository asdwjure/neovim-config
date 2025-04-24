return {
    "akinsho/toggleterm.nvim",
    tag = "v2.7.0",
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<C-_>]],
            direction = "horizontal",  -- or "float", "vertical", etc.
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
        })

        -- keybindings
        require('config.remap').toggleterm()
    end,
}
