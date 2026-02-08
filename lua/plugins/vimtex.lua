return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'evince'

    vim.g.vimtex_compiler_method = 'latexmk'

    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape',
        '-file-line-error',
        '-synctex=1', -- Required for SyncTeX (PDF <-> Code)
        '-interaction=nonstopmode',
      },
    }

    vim.g.vimtex_view_automatic = 1

    vim.g.vimtex_quickfix_ignore_filters = {
      'Underfull \\hbox',
      'Overfull \\hbox',
    }
  end,
}
