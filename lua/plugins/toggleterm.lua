return {
  'akinsho/toggleterm.nvim',
  version = "*",
  -- Defining keys here is robust because it handles lazy loading automatically
  keys = {
    { "<leader>d", "<cmd>lua _lazydocker_toggle()<CR>", desc = "LazyDocker" },
    { "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", desc = "LazyGit" },
    -- This handles opening/closing from Normal mode
    { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = "n", desc = "Terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      -- We leave this here, but the manual mapping in 'keys' is our backup
      open_mapping = [[<c-\>]], 
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    })

    -- Robust Terminal Navigation
    -- This allows you to use Ctrl+\ to CLOSE the terminal even while typing inside it
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', '<C-\\>', [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)
    end

    -- Run the keymaps whenever a terminal opens
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    local Terminal = require('toggleterm.terminal').Terminal

    -- Lazydocker Terminal
    local lazydocker = Terminal:new({
      cmd = "lazydocker",
      hidden = true,
      direction = "float",
      float_opts = { border = "curved" },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    -- Lazygit Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = { border = "curved" },
      on_open = function(term)
        vim.cmd("startinsert!")
        -- In terminal mode, we map 'q' to close
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    -- Global toggle functions
    function _lazydocker_toggle()
      lazydocker:toggle()
    end

    function _lazygit_toggle()
      lazygit:toggle()
    end
  end,
}
