return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  -- only load the plugin when you explicitly run :Neotree
  cmd = { 'Neotree' },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = false,

      filesystem = {
        -- don’t hijack netrw, so opening dirs (or nvim .) stays in netrw/disabled
        hijack_netrw_behavior = 'disabled',
        -- stop following the current file by default
        follow_current_file = { enabled = false },
      },

      window = {
        width = 50,
      },
    })
  end,
}
