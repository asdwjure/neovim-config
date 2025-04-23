return {
  'kdheepak/lazygit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- wire up your keymaps (must live under lua/config/remap.lua)
    require('config.remap').lazygit()
  end,
}
