vim.keymap.set("t", "<Esc>", function ()
   vim.cmd("stopinsert")
end)

vim.keymap.set({"n","t"}, "<C-x>", function ()
   vim.cmd("bdelete")
end)

-- Terminal!!!
_G.terminal = {
   buf = nil,
   win = nil
}
vim.keymap.set("n", "<leader>t", function ()
   -- initialize term buffer
   if not _G.terminal.buf or not vim.api.nvim_buf_is_valid(_G.terminal.buf) then
      _G.terminal.buf = vim.api.nvim_create_buf(false, true)

      vim.api.nvim_buf_call(_G.terminal.buf, function ()
         vim.cmd("term")
      end)
   end

   if _G.terminal.win and vim.api.nvim_win_is_valid(_G.terminal.win) then
      vim.keymap.set("n", "<Esc>", function ()
         vim.api.nvim_win_close(_G.terminal.win, true)
      end, {buffer = _G.terminal.buf})

      vim.api.nvim_set_current_win(_G.terminal.win)
      vim.cmd.startinsert()
   else
      _G.terminal.win = vim.api.nvim_open_win(_G.terminal.buf, true, {
         split = "below",
         height = math.ceil(vim.o.lines / 5),
      })

      vim.wo[_G.terminal.win].number = true
      vim.wo[_G.terminal.win].relativenumber = true
      vim.cmd("startinsert")
   end
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle diagnostics display

vim.g.virtual_text = true
vim.g.virtual_lines = false

vim.keymap.set("n", "<leader>d", function()
   vim.g.virtual_lines = not vim.g.virtual_lines
   vim.g.virtual_text = not vim.g.virtual_text
   vim.diagnostic.config {
      virtual_text = vim.g.virtual_text,
      virtual_lines = vim.g.virtual_lines,
   }
end, { desc = "Toggle virtual text/lines" })

vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() ~= 0 then return '<C-e><CR>'
  else return '<CR>'
  end
end, { expr = true, silent = true })

