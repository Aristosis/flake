---@diagnostic disable undefined_global
vim.loader.enable()

vim.lsp.enable {
   "lua_ls",
   "pyright",
   "rust_analyzer",
   "gopls",
   "clangd",
   "gdscript",
   "nil_ls",
   "org"
}

require("opts")
require("keybinds")

_G.org = "~/Media/Documents/org"

vim.pack.add { "https://github.com/zuqini/zpack.nvim" }
require("zpack").setup()

