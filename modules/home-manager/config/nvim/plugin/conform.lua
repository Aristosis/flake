vim.pack.add { {
   src = "https://github.com/stevearc/conform.nvim",
   version = vim.version.range("*"),
} }

local conform = require("conform")
conform.setup {
   formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      typescript = { "prettier" },
      markdown = { "prettier" },
      json = { "prettier" },
   },
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
