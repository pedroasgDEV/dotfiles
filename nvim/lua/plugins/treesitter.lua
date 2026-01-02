return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" }, -- Load lazily when opening a file
    config = function()
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        
        if not status_ok then
            return
        end

        configs.setup({
            -- A list of parser names, or "all"
            ensure_installed = { 
                "c", "lua", "vim", "vimdoc", "query", -- Neovim essentials
                "python", "rust", "cpp",              -- Your specific languages
                "markdown", "markdown_inline",        -- Documentation
                "bash", "json", "toml", "yaml"        -- Config files
            },

            -- Automatically install missing parsers when entering buffer
            auto_install = true,
            sync_install = false,



            highlight = { enable = true },
            indent = { enable = true },
            
            incremental_selection = { enable = true },
        })
    end
}
