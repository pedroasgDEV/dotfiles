return {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  ft = { "markdown", "tex" },
  config = function()
    require("peek").setup({
      auto_load = false, -- melhor deixar manual pra LaTeX
      close_on_bdelete = true,
      syntax = true,
      theme = "dark",
      update_on_change = true,
      app = "webview",
    })

    vim.keymap.set("n", "<leader>p", function()
      local peek = require("peek")
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end, { desc = "Peek Preview Toggle" })
  end,
}
