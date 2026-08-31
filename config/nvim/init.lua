vim.loader.enable()
_G.org = "~/Media/Documents/org"

require("opts")
require("keybinds")

vim.pack.add { "https://github.com/zuqini/zpack.nvim" }
require("zpack").setup()

vim.lsp.enable {
   "lua_ls",
   "pyright",
   "rust_analyzer",
   "gopls",
   "clangd",
   "gdscript",
   "nil_ls",
   "org",
}

_G.diagnostics = {
   virtual_text = true,
   virtual_lines = false,
}

vim.diagnostic.config {
   update_in_insert = false,
   severity_sort = true,
   jump = { float = true },
   float = { source = "if_many" },
   underline = { severity = { min = vim.diagnostic.severity.WARN } },
   virtual_text = _G.diagnostics.virtual_text,
   virtual_lines = vim.g.virtual_lines,
}
