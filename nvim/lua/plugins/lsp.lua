return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    -- Plugin that shows errors inline (configured to be non-intrusive)
    { 
      "chikko80/error-lens.nvim", 
      opts = {
        error_stack_trace = false, -- PREVENTS the giant red block on the screen
        delay = 500, -- Delay to avoid flickering while typing fast
      } 
    },
    -- Dependency needed for the keymaps defined below
    'ibhagwan/fzf-lua', 
  },
  config = function()
    -- ==========================================================
    -- 1. FUNCTION: TOGGLE LANGUAGE (PT-BR / EN-US)
    -- ==========================================================
    local function toggle_latex_langs()
      -- Neovim 0.11+ uses get_clients, fallback for 0.10
      local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
      
      -- UPDATED: Now looking for 'ltex_plus' instead of 'ltex'
      local clients = get_clients({ bufnr = 0, name = "ltex_plus" })
      local client = clients[1]

      if not client then
        vim.notify("LTeX LSP is not active yet. Wait a moment...", vim.log.levels.WARN)
        return
      end

      local current = client.config.settings.ltex.language
      local next_lang, label, spell

      -- Logic: PT -> Mixed -> EN -> PT
      if current == "pt-BR" then
        next_lang, label, spell = { "en-US", "pt-BR" }, "Mixed (EN/PT)", "en_us,pt_br"
      elseif type(current) == "table" then -- If it is currently mixed
        next_lang, label, spell = "en-US", "English (US)", "en_us"
      else
        next_lang, label, spell = "pt-BR", "Portuguese (BR)", "pt_br"
      end

      -- Update Settings
      client.config.settings.ltex.language = next_lang
      vim.opt_local.spelllang = spell
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      vim.notify("Language switched to: " .. label)
    end

    -- ==========================================================
    -- 2. DIAGNOSTICS CONFIG (Icons & Text)
    -- ==========================================================
    vim.diagnostic.config({
      update_in_insert = true, -- Change to false in case of crashes in scanning while typing
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    })

    -- ==========================================================
    -- 3. LSP ATTACH (Keymaps)
    -- ==========================================================
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', '<leader>c' .. keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local ft = vim.bo[event.buf].filetype
        if ft == 'tex' or ft == 'latex' or ft == 'bib' or ft == 'markdown' then
          vim.keymap.set('n', '<leader>li', toggle_latex_langs, { buffer = event.buf, desc = 'LaTeX: Cycle Language' })
        end

        -- Fzf-lua mappings
        local fzf = require('fzf-lua')
        map('d', fzf.lsp_definitions, 'Definition')
        map('r', fzf.lsp_references, 'References')
        map('i', fzf.lsp_implementations, 'Implementation')
        map('a', vim.lsp.buf.code_action, 'Code Action')
        map('e', fzf.lsp_document_diagnostics, 'Document Diagnostics')
        
        -- Rename
        map('n', vim.lsp.buf.rename, 'Rename')
      end,
    })

    -- ==========================================================
    -- 4. SERVER SETUP (Mason)
    -- ==========================================================
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    
    -- Server Configurations
    local servers = {
      clangd = {},
      pyright = {},
      texlab = {},   -- Builds the PDF / Basic completion
      bashls = {},
      -- Lua configuration
      lua_ls = { 
        settings = { 
          Lua = { 
            diagnostics = { globals = { 'vim' } } 
          } 
        } 
      },
      -- LTeX configuration (Using ltex_plus)
      ltex_plus = {
        filetypes = { "latex", "tex", "bib", "markdown" },
        settings = { 
          ltex = { 
            language = "pt-BR",
            checkFrequency = "save",
            sentenceCacheSize = 2000,
          } 
        }
      },
    }

    require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }
    
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          -- Skip rust manually (assuming you use rustaceanvim)
          if server_name == "rust_analyzer" then return end 
          
          local server = servers[server_name] or {}
          -- Merges default capabilities with server-specific ones
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
