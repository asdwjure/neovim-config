return {
  'EdenEast/nightfox.nvim',
  -- load at startup so colorscheme is available immediately
  lazy = false,
  config = function()
    -- any options you like; these are just examples
    require('nightfox').setup({
      options = {
        transparent = false,
        dim_inactive = false,
      },
    })

    -- Default colorscheme
    vim.cmd("colorscheme dayfox")
  end,
}
