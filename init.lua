vim.g.mapleader = " "

require("config.set")
require("config.lazy")
require("config.remap")

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    local ms = math.floor(stats.startuptime * 100) / 100
    print("Neovim loaded in " .. ms .. "ms with " .. stats.count .. " plugins")
  end,
})
