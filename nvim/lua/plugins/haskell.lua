return {
  {
    "neovimhaskell/haskell-vim",
    lazy = false,
    config = function()
      vim.g.haskell_enable_quantification = 1
      vim.g.haskell_enable_recursivedo = 1
      vim.g.haskell_enable_arrowsyntax = 1
      vim.g.haskell_enable_pattern_synonyms = 1
      vim.g.haskell_enable_typeroles = 1
      vim.g.haskell_enable_static_pointers = 1
      vim.g.haskell_backpack = 1

      vim.filetype.add({
        extension = {
          x = "haskell",
          y = "haskell",
          ly = "haskell",
        },
      })
    end,
  },

  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", 
    lazy = false,
    
    config = function()
      vim.g.haskell_tools = {
        tools = {
          hover = { auto_focus = false },
        },
        
        hls = {
          debug = false,
          capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),

          on_attach = function(client, bufnr)
            local ht = require('haskell-tools')
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
            local function map(mode, lhs, rhs, desc)
              opts.desc = desc
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- === PROTEÇÃO CONTRA ERROS EM .X / .Y / .CABAL ===
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local is_real_haskell = string.match(filename, "%.hs$") or string.match(filename, "%.lhs$")

            if is_real_haskell and client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end

            -- Atalhos (Haskell Cluster)
            map('n', '<leader>ha', vim.lsp.buf.code_action, "Haskell: Code Actions")
            map('n', '<leader>hc', vim.lsp.codelens.run,    "Haskell: Run CodeLens")
            map('n', '<leader>hs', ht.hoogle.hoogle_signature, "Haskell: Search Signature")
            map('n', '<leader>ht', vim.lsp.buf.hover,          "Haskell: Show Type/Hover")
            map('n', '<leader>hr', ht.repl.toggle, "Haskell: Toggle REPL")
            map('n', '<leader>hf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, "Haskell: Load Buffer in REPL")
            map('n', '<leader>hq', ht.repl.quit,   "Haskell: Quit REPL")
            map('n', '<leader>he', ht.lsp.buf_eval_all,    "Haskell: Evaluate Buffer")
            map('n', '<leader>hd', vim.lsp.buf.definition, "Haskell: Go to Definition")
          end,
        },
      }
    end,
  },
}
