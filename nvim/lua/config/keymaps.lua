vim.keymap.set("n", "-", "<cmd>Oil<CR>", {desc="Open Parent Directory in Oil"})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- =============================================================================
-- SELECTION
-- =============================================================================

map("n", "<M-Up>", "v<Up>", { desc = "Select Up" })
map("n", "<M-Down>", "v<Down>", { desc = "Select Down" })
map("n", "<M-Left>", "v<Left>", { desc = "Select Left" })
map("n", "<M-Right>", "v<Right>", { desc = "Select Right" })

map("v", "<M-Up>", "<Up>", { desc = "Expand Selection Up" })
map("v", "<M-Down>", "<Down>", { desc = "Expand Selection Down" })
map("v", "<M-Left>", "<Left>", { desc = "Expand Selection Left" })
map("v", "<M-Right>", "<Right>", { desc = "Expand Selection Right" })

map("i", "<M-Up>", "<Esc>v<Up>", { desc = "Select Up" })
map("i", "<M-Down>", "<Esc>v<Down>", { desc = "Select Down" })
map("i", "<M-Left>", "<Esc>v<Left>", { desc = "Select Left" })
map("i", "<M-Right>", "<Esc>v<Right>", { desc = "Select Right" })

map("n", "<C-a>", "ggVG", { desc = "Select All" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select All" })
map("v", "<C-a>", "ggVG", { desc = "Select All" })

-- =============================================================================
-- UNDU and REDU
-- =============================================================================

map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("n", "<C-S-z>", "<C-r>", { desc = "Redo" })
map("i", "<C-S-z>", "<C-o><C-r>", { desc = "Redo" })

-- =============================================================================
-- COPY
-- =============================================================================

map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map("v", "<C-v>", '"+P', { desc = "Paste over selection" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })

-- =============================================================================
-- DELETE SELECTION 
-- =============================================================================

map("v", "<BS>", '"_d', { desc = "Delete selection" })
