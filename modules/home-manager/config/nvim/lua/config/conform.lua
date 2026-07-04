vim.api.nvim_create_user_command("ToggleFormat", function()
   vim.b.disable_autoformat = not vim.b.disable_autoformat
   vim.g.disable_autoformat = not vim.g.disable_autoformat
end, {})

vim.g.disable_autoformat = true
vim.b.disable_autoformat = true

return {
   formatters_by_ft = _G.formatters_by_ft,
   notify_on_error = false,
   notify_no_formatters = false,
   format_after_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
         return
      end
      return {
         timeout_ms = 500,
         lsp_format = "fallback",
      }
   end,
}
