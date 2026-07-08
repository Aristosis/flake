---@diagnostic disable undefined_global
print("hi")
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

-- OPTS
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.virtual_text = true
vim.g.virtual_lines = false

vim.diagnostic.config {
   update_in_insert = false,
   severity_sort = true,
   jump = { float = true },
   float = { source = "if_many" },
   underline = { severity = { min = vim.diagnostic.severity.WARN } },
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

map("n", "<leader>b", function()
   vim.ui.input(
      {
         prompt = "Makeprg: ",
         default = vim.api.nvim_get_option_value("makeprg", { scope = "global" }),
      },
      function(input)
         if not input then return end
         vim.api.nvim_set_option_value("makeprg", input, { scope = "global" })
      end
   )
   end,
   { desc = "Makeprg" })

map("n", "<leader>r", function()
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

local augroup = vim.api.nvim_create_augroup("misc", {})
vim.api.nvim_create_autocmd("TextYankPost", {
   group = augroup,
   callback = function()
      (vim.hl or vim.highlight).on_yank()
   end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
   group = augroup,
   callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
   end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
   group = augroup,
   callback = function(event)
      local exclude = { "gitcommit" }
      local buf = event.buf
      if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
         return
      end
      vim.b[buf].lazyvim_last_loc = true
      local mark = vim.api.nvim_buf_get_mark(buf, '"')
      local lcount = vim.api.nvim_buf_line_count(buf)
      if mark[1] > 0 and mark[1] <= lcount then
         pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
   end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
   group = augroup,
   pattern = { "json", "jsonc", "json5" },
   callback = function()
      vim.opt_local.conceallevel = 0
   end,
})
-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
   group = augroup,
   callback = function(event)
      if event.match:match("^%w%w+:[\\/][\\/]") then
         return
      end
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
   end,
})

vim.api.nvim_create_autocmd("LspAttach", {
   group = augroup,
   callback = function(event)
      local map = function(keys, func, desc, mode)
         mode = mode or "n"
         vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
      end
      map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
      map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

      -- highlight symbol under cursor
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method("textDocument/documentHighlight", event.buf) then
         local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
         vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
         })

         vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
         })

         vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
            callback = function(event2)
               vim.lsp.buf.clear_references()
               vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
            end,
         })
      end

      if client and client:supports_method("textDocument/inlayHint", event.buf) then
         vim.api.nvim_create_user_command("ToggleInlayHints", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
         end, {})
      end
   end,
})

vim.cmd("colorscheme catppuccin")

