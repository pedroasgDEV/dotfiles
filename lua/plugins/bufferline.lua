return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      color_icons = true
      ,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        }
      },
    }
  }
}
