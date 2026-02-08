return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
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
    -- 3. LSP ATTACH (Keymaps: Direct + Leader backups)
    -- ==========================================================
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local fzf = require('fzf-lua')
        
        -- Helper function for local buffer mappings
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- --- DIRECT SHORTCUTS ---
        -- Note: If <C-.> or <C-,> doesn't work in your terminal, try <M-.> or <M-,> (Alt)
        map('n', '<C-.>', fzf.lsp_code_actions, 'Code Action (Direct)')
        map('n', '<C-,>', vim.lsp.buf.rename, 'Rename (Direct)')

        -- --- LEADER SHORTCUTS (Backups) ---
        map('n', '<leader>ca', fzf.lsp_code_actions, 'Code Action')
        map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
        
        -- Navigation & Diagnostics
        map('n', '<leader>cd', fzf.lsp_definitions, 'Go to Definition')
        map('n', '<leader>cl', fzf.lsp_references, 'References')
        map('n', '<leader>ce', fzf.lsp_document_diagnostics, 'Document Diagnostics')

        -- Specific for Text Files (LaTeX/Markdown)
        local ft = vim.bo[event.buf].filetype
        if ft == 'tex' or ft == 'latex' or ft == 'bib' or ft == 'markdown' then
          vim.keymap.set('n', '<leader>li', toggle_latex_langs, { buffer = event.buf, desc = 'Cycle Language' })
        end
      end,
    })

    -- ==========================================================
    -- 4. SERVER SETUP (Mason)
    -- ==========================================================
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Esta linha abaixo é CRUCIAL para o Blink injetar as sugestões:
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
    
    -- Server Configurations
    local servers = {
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
            completionEnabled = true,
          }
        }
      },
    }

    require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- Merges default capabilities with server-specific ones
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
