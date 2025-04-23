return {
    'rmagatti/auto-session',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('auto-session').setup({
            log_level                        = 'error',
            auto_session_enable_last_session = true, -- restore last session on startup
            auto_session_root_dir            = vim.fn.stdpath('data') .. '/sessions/',
            auto_session_enabled             = true,
            auto_session_save_on_exit        = true, -- save session when exiting Neovim
            auto_session_use_git_branch      = true, -- separate sessions per git branch
        })
    end,
}
