local map = vim.keymap.set

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

map("n", "<C-l>", "V", { desc = "Select current line" })
map("i", "<C-l>", "<Esc>V", { desc = "Select current line" })
map("v", "<C-l>", "j", { desc = "Expand selection down" })

map('v', '<Tab>', '>gv', { desc = 'Indent selection' })
map('v', '<S-Tab>', '<gv', { desc = 'Unindent selection' })

-- =============================================================================
-- UNDU and REDU
-- =============================================================================

map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo" })
map("n", "<C-M-z>", "<C-r>", { desc = "Redo", silent = true })
map("i", "<C-M-z>", "<C-o><C-r>", { desc = "Redo", silent = true }) 

-- =============================================================================
-- COPY
-- =============================================================================

map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut to system clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map("v", "<C-v>", '"+P', { desc = "Paste over selection" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste from system clipboard" })

map("n", "<M-S-Down>", "yyp", { desc = "Duplicate line down" })
map("i", "<M-S-Down>", "<Esc>yypgi", { desc = "Duplicate line down" })
map("v", "<M-S-Down>", "y'>p", { desc = "Duplicate selection down" })
map("n", "<M-S-Up>", "yyP", { desc = "Duplicate line up" })
map("i", "<M-S-Up>", "<Esc>yyPgi", { desc = "Duplicate line up" })
map("v", "<M-S-Up>", "y'<P", { desc = "Duplicate selection up" })

-- =============================================================================
-- DELETE SELECTION 
-- =============================================================================

map("v", "<BS>", '"_d', { desc = "Delete selection" })
map("n", "<BS>", "dd", { desc = "Delete current line" })

-- =============================================================================
-- LEADER SHORTCUTS (SPACE)   
-- =============================================================================

-- File Explorer (Oil)
map("n", "-", "<cmd>Oil<CR>", {desc="Open Parent Directory in Oil"})

-- Windows
map("n", "<leader>w", "<C-w>", { desc = "Window Actions", remap = true })
-- G commands
map("n", "<leader>q", "g", { desc = "G commands", remap = true })

-- =============================================================================
-- Buffline   
-- =============================================================================

map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Last Buffer" })
map("n", "<M-Tab>", "<cmd>bdelete<cr>", { desc = "Close current buffer" })

-- =============================================================================
-- Sessions 
-- =============================================================================

map('n', '<leader>ss', function()
    local name = vim.fn.input('Session name: ')
    if name ~= "" then require('mini.sessions').write(name) end
end, { desc = 'Save session' })

-- List and select sessions
map('n', '<leader>sl', function() require('mini.sessions').select() end, { desc = 'List sessions' })

-- Open Starter (Home screen)
map('n', '<leader>sh', function() require('mini.starter').open() end, { desc = 'Home screen' })

-- Delete a session
map('n', '<leader>sd', function() require('mini.sessions').select('delete') end, { desc = 'Delete session' })

-- =============================================================================
-- LATEX
-- =============================================================================

map('n', '<leader>ll', '<cmd>VimtexCompile<cr>', { desc = 'Toggle Compilation (Live)' })
map('n', '<leader>lv', '<cmd>VimtexView<cr>',    { desc = 'View PDF (Zathura)' })
map('n', '<leader>le', '<cmd>VimtexErrors<cr>',  { desc = 'Show Errors' })
map('n', '<leader>lc', '<cmd>VimtexClean<cr>',   { desc = 'Clean Auxiliary Files' })
map('n', '<leader>ls', '<cmd>VimtexStop<cr>',    { desc = 'Stop Compilation' })


-- Toggle Mini.Map (Enable/Disable)
map('n', '<Leader>m', '<cmd>lua MiniMap.toggle()<CR>', { desc = 'Minimap' })
