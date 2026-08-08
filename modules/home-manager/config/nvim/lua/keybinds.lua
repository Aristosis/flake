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

local function createTerminalWindow(sizeFactor)
   local height = math.ceil(vim.o.lines / sizeFactor)
   local width  = math.ceil(vim.o.columns / sizeFactor)
   local row    = math.ceil((vim.o.lines - height) / 2)
   local col    = math.ceil((vim.o.columns - width) / 2)

   return vim.api.nvim_open_win(_G.terminal.buf, true, {
      relative = "editor";
      height = height,
      width = width,
      row = row,
      col = col,
   })
end

local function createTerminalBuffer()
   local buf = vim.api.nvim_create_buf(false, true)

   return buf
end

vim.keymap.set(
   "n",
   "<leader>t",
   function()
      if _G.terminal.buf == nil or vim.api.nvim_buf_is_valid(_G.terminal.buf) == false then
        _G.terminal.buf = createTerminalBuffer()
      end

      if not _G.terminal.win or not vim.api.nvim_win_is_valid(_G.terminal.win) then
         _G.terminal.win = createTerminalWindow(1.4)
      else
         vim.api.nvim_set_current_win(_G.terminal.win)
      end


      if vim.bo[_G.terminal.buf].buftype ~= "terminal" then

         vim.api.nvim_buf_call(_G.terminal.buf, vim.cmd.terminal)
         vim.api.nvim_buf_call(_G.terminal.buf, vim.cmd.startinsert)
         vim.bo[_G.terminal.buf].buflisted = false

         vim.keymap.set("n", "<Esc>", function()
            vim.api.nvim_win_close(_G.terminal.win, true)
         end, {buffer = _G.terminal.buf})
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

