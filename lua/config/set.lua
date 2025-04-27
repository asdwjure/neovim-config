vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"


----------------
---Hightlight text when yanking
local function set_yank_hl()
  vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#FF8C00', fg = 'NONE' })
end

set_yank_hl()

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = set_yank_hl,
})

local yank_grp = vim.api.nvim_create_augroup('YankHighlightGrp', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_grp,
  callback = function()
    vim.highlight.on_yank {
      higroup = 'YankHighlight',
      timeout = 150,
    }
  end,
})
----------------
