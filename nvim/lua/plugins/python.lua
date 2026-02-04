return {
  -- 1. Mason: Manages installation of LSPs, Formatters, and Debuggers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "debugpy",
        "ruff",
      },
    },
  },

  -- 2. LSP Config: Python Language Server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "strict",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- Helps Pyright find your 'lib' folder
                extraPaths = { "." },
              },
            },
          },
        },
      },
    },
  },

  -- 3. Conform: Auto-formatting on save using Ruff
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_fix" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- 4. DAP: Debugging configuration
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      -- Default fallback path to Mason's debugpy
      local path = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
      require("dap-python").setup(path)
    end,
  },

  -- 5. Venv Selector: The bridge between Pixi and Neovim
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { 
      "neovim/nvim-lspconfig", 
      "nvim-telescope/telescope.nvim", 
      "mfussenegger/nvim-dap-python" 
    },
    branch = "regexp", -- Required for advanced path searching
    event = "VeryLazy",
    keys = {
      -- Shortcut to open the selector: Space + v + s
      { "<leader>cp", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv (Pixi)" },
    },
    opts = {
      settings = {
        options = {
          notify_user_on_venv_change = true,
        },
        search = {
          -- Specific search for Pixi environments
          pixi = {
            command = "fd 'python$' .pixi/envs --full-path --color never",
          },
        },
      },
    },
  },
}
