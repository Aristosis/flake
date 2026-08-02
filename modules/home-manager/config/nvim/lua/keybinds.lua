vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set(
   "n",
   "<leader>c",
   function()
      vim.o.autocomplete = not vim.o.autocomplete
   end
)

-- Terminal!!!
_G.terminal = {
   buf = nil,
   win = nil
}

vim.keymap.set(
   "n",
   "<leader>t",
   function ()

      if not _G.terminal.buf or not vim.api.nvim_buf_is_valid(_G.terminal.buf) then
         _G.terminal.buf = vim.api.nvim_create_buf(false, true)

         vim.api.nvim_buf_call(_G.terminal.buf, function ()
            vim.cmd("term")
         end)
      end

      if _G.terminal.win and vim.api.nvim_win_is_valid(_G.terminal.win) then
         vim.api.nvim_set_current_win(_G.terminal.win)
         vim.cmd.startinsert()
      else

         vim.keymap.set("n", "<Esc>", function ()
            vim.api.nvim_win_close(_G.terminal.win, true)
         end, {buffer = _G.terminal.buf})

         local factor = 1.4
         local height = math.ceil(vim.o.lines / factor)
         local width = math.ceil(vim.o.columns / factor)
         local row = math.ceil((vim.o.lines / 2) - (height / 2))
         local col = math.ceil((vim.o.columns / 2) - (width / 2))

         _G.terminal.win = vim.api.nvim_open_win(_G.terminal.buf, true, {
            relative = "editor";
            height = height,
            width = width,
            row = row,
            col = col,
         })

         vim.wo[_G.terminal.win].number = true
         vim.wo[_G.terminal.win].relativenumber = true
         vim.cmd("startinsert")
      end
   end
)

vim.keymap.set(
   "t",
   "<S-Esc>",
   function ()
      vim.cmd("stopinsert")
   end
)



-- Toggle diagnostics display
vim.g.virtual_text = true
vim.g.virtual_lines = false

local function reconf_diags()
   vim.diagnostic.config {
      virtual_text = vim.g.virtual_text,
      virtual_lines = vim.g.virtual_lines,
   }
end

vim.keymap.set(
   "n",
   "<leader>d",
   function()
      vim.g.virtual_text = not vim.g.virtual_text
      reconf_diags()
   end,
   { desc = "Toggle virtual text" }
)

vim.keymap.set(
   "n",
   "<leader>D",
   function()
      vim.g.virtual_lines = not vim.g.virtual_lines
      reconf_diags()
   end,
   { desc = "Toggle virtual lines" }
)

-- let me press enter without accepting autocomplete sheiz
vim.keymap.set(
   'i',
   '<CR>',
   function()
      if vim.fn.pumvisible() ~= 0 then
         return '<C-e><CR>'
      else
         return '<CR>'
      end
   end,
   { expr = true, silent = true }
)

