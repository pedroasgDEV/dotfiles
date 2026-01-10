return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    -- GLOBAL DIAGNOSTIC CONFIGURATION
    vim.diagnostic.config({
      update_in_insert = true, 
      virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
      signs = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
      underline = {
        severity = { min = vim.diagnostic.severity.WARN },
      },
    })

    -- Create an autocmd that runs when an LSP attaches to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, '<leader>c' .. keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Keymaps using Fzf-lua for a VS Code-like experience
        map('d', require('fzf-lua').lsp_definitions, 'Definition')
        map('r', require('fzf-lua').lsp_references, 'References')
        map('i', require('fzf-lua').lsp_implementations, 'Implementation')
        map('t', require('fzf-lua').lsp_typedefs, 'Type Definition')
        map('s', require('fzf-lua').lsp_document_symbols, 'Document Symbols')
        map('w', require('fzf-lua').lsp_live_workspace_symbols, 'Workspace Symbols')
        map('n', vim.lsp.buf.rename, 'Rename')
        map('a', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        map('e', require('fzf-lua').lsp_document_diagnostics, 'Document Diagnostics')


        -- Buffer management and Code Actions
        vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions, { buffer = event.buf, desc = 'LSP: Goto Definition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = 'LSP: Goto Declaration' })      end,
    })

    -- Server Capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Define Servers to be installed by Mason
    local servers = {
      clangd = {},    -- C/C++
      pyright = {},   -- Python
      texlab = {},    -- LaTeX
      marksman = {},  -- Markdown
      bashls = {},    -- Bash
      lua_ls = {      -- Lua for Neovim config
        settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
      },
      ltex = {        -- Grammar and Spell check (PT/EN)
        settings = { ltex = { language = "pt-BR" } }
      },
    }

    -- Install servers via Mason Tool Installer
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { 'stylua' })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup Mason LSP Config with Handlers
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          -- They are handled by specialized plugins below
          if server_name == "rust_analyzer" or server_name == "hls" then
            return
          end

          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
