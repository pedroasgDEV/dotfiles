return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      -- SYSTEM SETTINGS (Persistent Folds)
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      
      -- Define what to save in the file view (folds, cursor position, and directory)
      vim.opt.viewoptions = { "folds", "cursor", "curdir" }

      -- Autocommands to save/load the fold state automatically
      local fold_group = vim.api.nvim_create_augroup('PersistentFolds', { clear = true })
      
      -- Save view when leaving a buffer
      vim.api.nvim_create_autocmd('BufWinLeave', {
        group = fold_group,
        pattern = '*.*',
        callback = function() vim.cmd('silent! mkview') end,
      })
      
      -- Load view when entering a buffer
      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = fold_group,
        pattern = '*.*',
        callback = function() vim.cmd('silent! loadview') end,
      })

      -- UFO SETUP
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Uses Treesitter for intelligent block detection
          return {'treesitter', 'indent'} 
        end
      })

      -- KEYMAPS
      vim.keymap.set({'n', 'x'}, '<M-a>', 'za', { desc = 'Toggle Fold (Hide/Show)' })
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    end,
  }
}
