return {
  "chentoast/marks.nvim",
  config = function()
    require("marks").setup({
      -- Customize here if needed
      default_mappings = true,
      signs = true, -- ← THIS SHOWS MARKS IN SIGN COLUMN
    })
  end,
}
