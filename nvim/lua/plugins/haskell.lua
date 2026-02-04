return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", -- Recommended version
    lazy = false,   -- Must load eagerly to detect .hs, .cabal, package.yaml
    
    config = function()
      -- Configure the plugin via global variable before it fully loads
      vim.g.haskell_tools = {
        
        --- TOOLS CONFIGURATION
        tools = {
          -- Show type hints (inlay hints) automatically
          inlay_hints = {
            auto = true,
          },
          -- Hover configuration (floating window)
          hover = {
            auto_focus = false, 
          },
          -- Code Lens (e.g., "Run" button appearing above main function)
          codeLens = {
            autoRefresh = true,
          },
        },

        --- LSP CONFIGURATION (HLS)
        hls = {
          -- Automatically set the log level to warn/error to avoid noise
          -- Log file location: ~/.cache/nvim/haskell-tools.log
          debug = false,

          -- KEYBINDINGS: The "Haskell Cluster"
          -- These mappings are only active when opening a Haskell file
          on_attach = function(client, bufnr)
            local ht = require('haskell-tools')
            local opts = { noremap = true, silent = true, buffer = bufnr }

            -- Helper function to make mapping cleaner
            local function map(mode, lhs, rhs, desc)
              opts.desc = desc
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- === HASKELL CLUSTER (<leader>h...) ===

            -- [D]ocumentation & Hoogle
            map('n', '<leader>hs', ht.hoogle.hoogle_signature, "Haskell: Search Signature (Hoogle)")
            map('n', '<leader>hh', function() 
               -- Requires telescope.nvim
               require('telescope').extensions.ht.hoogle_signature() 
            end, "Haskell: Search Hoogle (Telescope)")

            -- [R]EPL (GHCi Integration)
            map('n', '<leader>hr', ht.repl.toggle, "Haskell: Toggle REPL")
            map('n', '<leader>hl', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, "Haskell: Load Buffer in REPL")
            map('n', '<leader>hq', ht.repl.quit, "Haskell: Quit REPL")

            -- [E]valuation (Live code testing)
            map('n', '<leader>he', ht.lsp.buf_eval_all, "Haskell: Evaluate Buffer")

            -- [C]ode Actions & Navigation
            map('n', '<leader>hc', vim.lsp.codelens.run, "Haskell: Run CodeLens")
            map('n', '<leader>ha', vim.lsp.buf.code_action, "Haskell: Code Actions")
            
            -- [T]ype Information (Standard LSP overrides for consistency)
            map('n', '<leader>ht', vim.lsp.buf.hover, "Haskell: Show Type/Hover")
            map('n', '<leader>hd', vim.lsp.buf.definition, "Haskell: Go to Definition")
            map('n', '<leader>hi', vim.lsp.buf.implementation, "Haskell: Go to Implementation")
          end,
        },
      }
    end,
  },

  -- CONFLICT PREVENTION
  -- We must ensure the standard lspconfig does NOT try to start 'hls'
  -- because haskell-tools is already doing it.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      -- Explicitly remove hls from standard setup to avoid double-loading
      opts.servers.hls = nil 
    end,
  },
}
