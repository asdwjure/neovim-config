return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Telescope)" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Telescope)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers (Telescope)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files (Telescope)" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", "%.git" },
      path_display = { "smart" },
    },
    pickers = {
      find_files = {
        find_command = {
          "fd",
          "--type",
          "f",
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
