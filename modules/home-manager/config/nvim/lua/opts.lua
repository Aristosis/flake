vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.virtual_text = true
vim.g.virtual_lines = false

vim.diagnostic.config {
   update_in_insert = false,
   severity_sort = true,
   float = { source = "if_many" },
   underline = { severity = { min = vim.diagnostic.severity.WARN } },

   jump = { float = true },
   virtual_text = vim.g.virtual_text,
   virtual_lines = vim.g.virtual_lines,
}

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>d", function()
   vim.g.virtual_lines = not vim.g.virtual_lines
   vim.g.virtual_text = not vim.g.virtual_text

   vim.diagnostic.config {
      virtual_text = vim.g.virtual_text,
      virtual_lines = vim.g.virtual_lines,
   }
end, { desc = "Toggle virtual text/lines" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-S-h>", "<C-w>H", { desc = "Move window left" })
map("n", "<C-S-l>", "<C-w>L", { desc = "Move window right" })
map("n", "<C-S-j>", "<C-w>J", { desc = "Move window down" })
map("n", "<C-S-k>", "<C-w>K", { desc = "Move window up" })

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
vim.o.list = true
vim.opt.listchars = {
   trail = "·",
   nbsp = "␣",
   tab = "▏ ",
   leadmultispace = "▏   ",
}
vim.o.wrap = false
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.showmode = false
vim.o.pumblend = 30
vim.o.pumheight = 10
vim.o.signcolumn = "yes"
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.o.smartindent = true
vim.o.formatoptions = "jcroqlnt"
vim.o.foldmethod = "manual"
