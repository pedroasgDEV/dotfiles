return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave", "TextChanged" },
      cancel_deferred_save = { "InsertEnter", "TextChanged" },
    },
    debounce_delay = 1500, 
    condition = function(buf)
      local fn = vim.fn
      local ft = vim.bo[buf].filetype

      if vim.tbl_contains({ "oil", "toggleterm", "lazy", "help", "qf", "netrw" }, ft) then
        return false
      end
      
      if not vim.bo[buf].modifiable or fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      
      return true
    end,
    write_mode = "auto",
  },
}
