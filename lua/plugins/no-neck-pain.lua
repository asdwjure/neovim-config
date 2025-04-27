return {
    'shortcuts/no-neck-pain.nvim',
    version = '2.*',
    event = "VimEnter",
    priority = 1, -- very low priority
    config = function()
        require('no-neck-pain').setup({
            -- desired width of the focused buffer;
            -- when your total window width is < this, it won’t create padding
            width = 160,

            mappings = {
                enabled = false, -- mappings defined in remap.lua
            },
            -- you can tweak these defaults if you like more/less padding:
            minSideBufferWidth = 10,
            killAllBuffersOnDisable = false,
            fallbackOnBufferDelete = true,
            autocmds = {
                enableOnVimEnter = true,
            }
        })
    end,
}
