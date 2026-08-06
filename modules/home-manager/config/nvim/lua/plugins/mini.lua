---@diagnostic disable:undefined-global MiniExtra
return {
   "nvim-mini/mini.nvim",
   version = "main",
   config = function()
      require("mini.extra").setup()

      require("mini.ai").setup { silent = true }
      require("mini.align").setup()
      require("mini.icons").setup()
      require("mini.indentscope").setup()
      require("mini.surround").setup {
         search_method = "cover_or_next",
         silent = true,
      }
      require("mini.splitjoin").setup()
      require("mini.cursorword").setup()
      require("mini.statusline").setup()

      local pick = require("mini.pick")
      pick.setup { options = { content_from_bottom = true, use_cache = true } }

      vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files,       { desc = "Pick files" })
      vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers,     { desc = "Pick buffers" })
      vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live,   { desc = "Pick through grep" })
      vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Pick diagnostics" })

      vim.keymap.set("n", "<leader>fm", MiniExtra.pickers.marks,      { desc = "Pick marks" })
      vim.keymap.set(
         "n",
         "<leader>F",
         function()
            MiniExtra.pickers.marks("global")
         end,
         { desc = "Pick global marks" }
      )

      vim.keymap.set(
         "n",
         "<leader>fl",
         function()
            MiniExtra.pickers.lsp("document_symbol")
         end,
         { desc = "Pick lsp symbols" }
      )

      vim.keymap.set(
         "n",
         "<leader>fr",
         function()
            MiniExtra.pickers.lsp("references")
         end,
         { desc = "Pick references" }
      )

      require("mini.files").setup {
         windows = {
            preview = true
         }
      }

      vim.keymap.set("n", "<leader>-", MiniFiles.open, { desc = "Open files" })
      vim.keymap.set(
         "n",
         "<leader>_",
         function()
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
         end,
         { desc = "Open files in buffer directory" }
      )
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup {
         highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
            fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
            hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
            todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
            note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
         },
      }

   end
}
