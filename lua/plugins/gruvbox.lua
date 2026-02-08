return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_indent_guides = false,
      inverse = true,
      contrast = "",
      palette_overrides = {},
      overrides = {
        TabLineSel = { fg = "#282828", bg = "#ebdbb2" },
      },
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.cmd("colorscheme gruvbox")

    local set_hl = vim.api.nvim_set_hl
    set_hl(0, "@markup.link.url.markdown_inline", { link = "Special" })
    set_hl(0, "@markup.link.label.markdown_inline", { link = "WarningMsg" })
    set_hl(0, "@markup.italic.markdown_inline", { link = "Exception" })
    set_hl(0, "@markup.raw.markdown_inline", { link = "String" })
    set_hl(0, "@markup.list.markdown", { link = "Function" })
    set_hl(0, "@markup.quote.markdown", { link = "Error" })
    set_hl(0, "@markup.list.checked.markdown", { link = "WarningMsg" })
  end,
}
