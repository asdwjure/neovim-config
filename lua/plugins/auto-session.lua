return {
  'rmagatti/auto-session',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('auto-session').setup({
      -- where all session files live
      root_dir                 = vim.fn.stdpath('data') .. '/sessions/',

      -- auto-create a session file for *this* project (cwd) on exit
      auto_create              = true,

      -- auto-save it when you exit nvim
      auto_save                = true,

      -- auto-restore it on startup *only* if there's a session for this cwd
      auto_restore             = true,

      -- do *not* fall back to the “last” session when starting in a new dir
      auto_restore_last_session = false,

      -- name sessions *only* by their project path (not by git-branch)
      git_use_branch_name      = false,

      -- keep auto-session from kicking in under your home or root dir
      suppressed_dirs          = { '~/', '/' },
    })
  end,
}

