---@diagnostic disable undefined_global
vim.loader.enable()

vim.lsp.enable {
   "lua_ls",
   "pyright",
   "rust_analyzer",
   "gopls",
   "clangd",
   "gdscript",
   "nil_ls"
}

require("opts")
require("keybinds")

vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
require("zpack").setup()
