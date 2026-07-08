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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.virtual_text = true
vim.g.virtual_lines = false
vim.o.title = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.grepprg = "rg --vimgrep"
vim.o.foldlevel = 99
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.swapfile = false
vim.o.undofile = true
vim.opt.sessionoptions:append { "globals" }
vim.o.completeopt = "menu,menuone,popup,noinsert,fuzzy"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.wrap = false
vim.o.list = true
vim.opt.listchars = {
   trail = "·",
   nbsp = "␣",
   tab = "» ",
   -- leadmultispace = "▏   ",
}
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.showmode = false
vim.o.pumblend = 30
vim.o.pumheight = 10
vim.o.signcolumn = "yes"
vim.o.formatoptions = "jcroqlnt"
vim.o.smartindent = true
vim.opt.shortmess:append { W = true, I = true, c = true }

-- Rename within same line
vim.keymap.set("n", "<leader>r", function()
   vim.ui.input({ prompt = "Replace <x> with <y>: " }, function(test)
      if not test then
         return
      end
      next_arg = string.gmatch(test, "(%w+)")
      local e = next_arg()
      local d = next_arg()

      if e and d then
         vim.cmd("s/" .. e .. "/" .. d .. "/g")
      end
   end)
end)

local augroup = vim.api.nvim_create_augroup("misc", {})
vim.api.nvim_create_autocmd("TextYankPost", {
   group = augroup,
   callback = function()
      (vim.hl or vim.highlight).on_yank()
   end,
})

vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })
require("zpack").setup()
