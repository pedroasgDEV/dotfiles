return {
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^4", 
    lazy = false, -- Importante para detectar arquivos ao abrir
    
    config = function()
      -- 1. Configurar a variável Global ANTES de carregar ferramentas internas
      vim.g.haskell_tools = {
        tools = {
          -- REMOVIDO: inlay_hints (causava o erro)
          -- REMOVIDO: codeLens (autoRefresh já é true por padrão)
          
          hover = { 
            auto_focus = false 
          },
        },
        
        hls = {
          debug = false,
          
          -- IMPORTANTE: Passa as capacidades do Blink/CMP para o HLS
          capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),

          -- Esta função roda APENAS quando o LSP conecta com sucesso
          on_attach = function(client, bufnr)
            local ht = require('haskell-tools')
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
            local function map(mode, lhs, rhs, desc)
              opts.desc = desc
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- === ATIVAR INLAY HINTS (Nativo do Neovim) ===
            -- Substitui a config antiga que dava erro
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end

            -- === HASKELL CLUSTER (<leader>h...) ===
            
            -- Code Actions (Essenciais)
            map('n', '<leader>ha', vim.lsp.buf.code_action, "Haskell: Code Actions")
            map('n', '<leader>hc', vim.lsp.codelens.run,    "Haskell: Run CodeLens")
            
            -- Hoogle & Docs
            map('n', '<leader>hs', ht.hoogle.hoogle_signature, "Haskell: Search Signature")
            map('n', '<leader>ht', vim.lsp.buf.hover,          "Haskell: Show Type/Hover")
            
            -- REPL (GHCi)
            map('n', '<leader>hr', ht.repl.toggle, "Haskell: Toggle REPL")
            map('n', '<leader>hf', function() ht.repl.toggle(vim.api.nvim_buf_get_name(0)) end, "Haskell: Load Buffer in REPL")
            map('n', '<leader>hq', ht.repl.quit,   "Haskell: Quit REPL")

            -- Navegação e Avaliação
            map('n', '<leader>he', ht.lsp.buf_eval_all,    "Haskell: Evaluate Buffer")
            map('n', '<leader>hd', vim.lsp.buf.definition, "Haskell: Go to Definition")
          end,
        },
      }
    end,
  },
}
