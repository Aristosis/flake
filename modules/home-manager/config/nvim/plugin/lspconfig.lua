vim.pack.add {
   {
      src = "https://github.com/Saghen/blink.cmp",
      version = vim.version.range("*"),
   },
   {
      src = "https://github.com/stevearc/conform.nvim",
      version = vim.version.range("*"),
   },
   { src = "https://github.com/j-hui/fidget.nvim" },
   { src = "https://github.com/neovim/nvim-lspconfig" },
   { src = "https://github.com/mason-org/mason.nvim" },
   { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
   { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
   { src = "https://github.com/NMAC427/guess-indent.nvim" }
}

local blink = require("blink.cmp")
blink.setup {
   -- fuzzy = {
   --    -- implementation = "lua",
   -- },
   signature = {
      enabled = true,
   },
}

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()
mason_lspconfig.setup()

local conform = require("conform")
conform.setup {
   formatters_by_ft = {
      lua = { "stylua" },
   },
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

local guess_indent = require("guess-indent")
guess_indent.setup()
