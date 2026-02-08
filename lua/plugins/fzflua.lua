return {
  "ibhagwan/fzf-lua",
  -- Load only when calling the command or using the keys below
  cmd = "FzfLua",
  dependencies = { "echasnovski/mini.icons" }, -- Link your existing mini.icons
  
  -- Main configuration
  opts = {
    "max-perf", -- Profile for maximum speed
    file_icon_padding = " ",
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        layout = "flex", -- Adjusts preview position based on screen width
        scrollbar = false, -- Cleaner UI without scrollbars
      },
    },
    keymap = {
      -- Navigation inside the FZF popup
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
      },
    },
  },

  -- Keybindings (VS Code Style)
  keys = {
    -- Files and Grep
    { "<leader>ff", function() require('fzf-lua').files() end, desc = "Find Files" },
    { "<leader>fg", function() require('fzf-lua').live_grep() end, desc = "Find Text (Grep)" },
    
    -- VS Code Style Search (Current Buffer)
    { "<C-f>", function() require('fzf-lua').lgrep_curbuf() end, desc = "Search in current buffer" },
    
    -- Buffers and History
    { "<leader><leader>", function() require('fzf-lua').buffers() end, desc = "Find Buffers" },
    { "<leader>fo", function() require('fzf-lua').oldfiles() end, desc = "Recent Files" },
    
    -- Neovim Config and Help
    { "<leader>fc", function() require('fzf-lua').files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config" },
    { "<leader>fh", function() require('fzf-lua').helptags() end, desc = "Find Help" },
  }
}
