---@diagnostic disable:undefined-global MiniExtra
return {
   "nvim-mini/mini.nvim",
   version = "main",
   event = "VeryLazy",
   config = function()
      require("mini.extra").setup()
      require("mini.align").setup()
      require("mini.bracketed").setup()

      local clue = require("mini.clue")
      clue.setup {
         clues = {
            clue.gen_clues.builtin_completion(),
            clue.gen_clues.g(),
            clue.gen_clues.square_brackets(),
            clue.gen_clues.marks(),
            clue.gen_clues.registers(),
            clue.gen_clues.windows(),
            clue.gen_clues.z(),
         },
         triggers = {
            { mode = { "n", "x" }, keys = "<Leader>" },
            { mode = "n", keys = "[" },
            { mode = "n", keys = "]" },
            { mode = "i", keys = "<C-x>" },
            { mode = { "n", "x" }, keys = "g" },
            { mode = { "n", "x" }, keys = "'" },
            { mode = { "n", "x" }, keys = "`" },
            { mode = { "n", "x" }, keys = "\"" },
            { mode = { "i", "c" }, keys = "<C-r>" },
            { mode = "n", keys = "<C-w>" },
            { mode = { "n", "x" }, keys = "z" },
         },
      }

      require("mini.icons").setup()

      local indent_scope = require("mini.indentscope")
      indent_scope.setup {
         symbol = "▏",
         options = { try_as_border = true },
         draw = { animation = indent_scope.gen_animation.none() },
      }

      require("mini.surround").setup {
         search_method = "cover_or_next",
         silent = true,
      }

      require("mini.splitjoin").setup()
      require("mini.cursorword").setup()
      require("mini.statusline").setup()

      local pick = require("mini.pick")
      pick.setup { options = { content_from_bottom = true, use_cache = true } }

      vim.keymap.set("n", "<leader><leader>", MiniPick.builtin.files, { desc = "Pick files" })
      vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers, { desc = "Pick buffers" })
      vim.keymap.set("n", "<leader>d", MiniExtra.pickers.diagnostic, { desc = "Pick diagnostics" })
      vim.keymap.set("n", "<leader>f", MiniPick.builtin.grep_live, { desc = "Pick through grep" })
      vim.keymap.set("n", "<leader>m", MiniExtra.pickers.marks, { desc = "Pick marks" })
      vim.keymap.set("n", "<leader>s", function()
         MiniExtra.pickers.lsp { scope = "document_symbol" }
      end, { desc = "Pick LSP symbols" })
      vim.keymap.set("n", "<leader>r", function()
         MiniExtra.pickers.lsp { scope = "references" }
      end, { desc = "Pick references" })

      require("mini.files").setup {
         windows = { preview = true },
         mappings = {
            go_in = "L",
            go_out = "H",
         },
      }

      vim.keymap.set("n", "<leader>-", MiniFiles.open, { desc = "Files" })
      vim.keymap.set("n", "<leader>_", function()
         local s, e = pcall(function()
            MiniFiles.open(vim.api.nvim_buf_get_name(0))
         end)
         if not s or e then print("Buffer path not valid.") end
      end, { desc = "Files (pwd)" })

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
   end,
}
