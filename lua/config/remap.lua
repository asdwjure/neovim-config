vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>")

vim.keymap.set("n", "<leader>fe", vim.cmd.Neotree)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Move selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at the middle of the screen when scrolling/jumping/searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Window resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Toggle no-neck-pain
vim.keymap.set('n', '<leader>np', '<cmd>NoNeckPain<CR>')

-- Close buffer, keep window
vim.keymap.set("n", "<leader>bd", ":bp | bd #<CR>", { desc = "Kill Buffer (keep layout)" })

-- Select last buffer
vim.keymap.set("n", "<leader>bb", ":b#<CR>", { desc = "Select last buffer" })

-- Press ESC to exit terminal mode (otherwise requires <C-\> <C-n> which is too long to type and life is too short
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- greatest remap ever
-- Paste but keep paste buffer intact
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

local M = {}

--- Set up Telescope keybindings
function M.telescope()
    local builtin = require('telescope.builtin')
    local opts = { noremap = true, silent = true }
    local map = vim.keymap.set

    -- basic pickers
    map('n', '<leader>ff', builtin.find_files, opts)
    map('n', '<leader>fg', builtin.live_grep, opts)
    map('n', '<leader>fb', builtin.buffers, opts)

    -- show only oldfiles under the current working directory
    map('n', '<leader>fr', function()
        builtin.oldfiles {
            cwd = vim.fn.getcwd(),
        }
    end, opts)

    -- include hidden / no-ignore variants
    map('n', '<leader>fF', function()
        builtin.find_files({ hidden = true, no_ignore = true })
    end, opts)

    map('n', '<leader>fG', function()
        builtin.live_grep({ hidden = true, no_ignore = true })
    end, opts)
end

function M.harpoon()
    local harpoon = require('harpoon') -- single entry point
    local map     = vim.keymap.set
    local opts    = { noremap = true, silent = false }

    -- add current file
    map('n', '<leader>ha', function()
        harpoon:list():add()
    end, opts)

    -- toggle the UI
    map('n', '<leader>hh', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts)

    -- navigate to marks 1–4
    for i = 1, 4 do
        map('n', '<leader>h' .. i, function()
            harpoon:list():select(i)
        end, opts)
    end
end

function M.lazygit()
    local map  = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- open LazyGit in the current working directory
    map('n', '<leader>gg', '<cmd>LazyGit<CR>', opts)
    -- open LazyGit scoped to the current file’s root
    map('n', '<leader>gG', '<cmd>LazyGitCurrentFile<CR>', opts)
    -- edit your LazyGit config
    map('n', '<leader>gC', '<cmd>LazyGitConfig<CR>', opts)
    -- open LazyGit with project‐wide filter UI
    map('n', '<leader>gF', '<cmd>LazyGitFilter<CR>', opts)
    -- open LazyGit filtered to current file’s commits
    map('n', '<leader>gf', '<cmd>LazyGitFilterCurrentFile<CR>', opts)
end

--- LSP keybindings (called from lsp-zero's on_attach)
function M.lsp(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map  = vim.keymap.set

    map('n', '<leader>cd', vim.lsp.buf.definition, opts)
    map('n', '<leader>cD', vim.lsp.buf.declaration, opts)
    map('n', '<leader>ci', vim.lsp.buf.implementation, opts)
    map('n', '<leader>cr', vim.lsp.buf.references, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '[d', vim.diagnostic.goto_prev, opts)
    map('n', ']d', vim.diagnostic.goto_next, opts)
    map('n', '<leader>ld', vim.diagnostic.open_float, opts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    map('n', '<leader>cn', vim.lsp.buf.rename, opts)
    map('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
end

--- Window-picker keymap (pick a window and jump there)
function M.window_picker()
    local wp   = require('window-picker')
    local map  = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<leader>wp', function()
        -- pop up the picker, get the chosen window id
        local win_id = wp.pick_window()
        if win_id then
            vim.api.nvim_set_current_win(win_id)
        end
    end, opts)
end

--- Toggle through colorschemes
function M.theme()
  local themes = { 'rose-pine', 'dayfox', 'terafox' } -- list all themes to cycle through
  local idx    = (vim.g.theme_idx or 1) % #themes + 1
  vim.g.theme_idx = idx
  vim.cmd('colorscheme ' .. themes[idx])
  print('Colorscheme: ' .. themes[idx])
end

vim.keymap.set('n', '<leader>ut', M.theme)

-- Toggleterm terminal plugin keymaps
function M.toggleterm()
    vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
end

return M
