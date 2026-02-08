return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "n",
            desc = "Format code",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            markdown = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = true,
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
        },
    },
}
