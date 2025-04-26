return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false, -- show gitignored files
          },
          follow_current_file = {
            enabled = true, -- This will make Neo-tree follow the current file
            leave_dirs_open = false, -- Optional: keep parent directories open
          },
        },
      })
    end,
  },
}
