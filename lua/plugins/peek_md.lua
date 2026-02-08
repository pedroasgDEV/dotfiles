return {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")

        peek.setup({
            app = 'webview',
            filetype = { 'markdown' }, -- Garante que o plugin reconheça o tipo de arquivo
        })

        -- Criar comando global para teste
        vim.api.nvim_create_user_command("PeekOpen", peek.open, {})

        -- Autocmd usando um método diferente (Vimscript bridge) que é mais estável
        vim.cmd([[
          augroup PeekAutoOpen
            autocmd!
            autocmd FileType markdown lua require('peek').open()
          augroup END
        ]])
    end,
}
