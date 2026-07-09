vim.pack.add { {
   src = "https://github.com/nvim-mini/mini.nvim",
   version = "main",
} }

require("mini.extra").setup()
local ai = require("mini.ai")
local git = require("mini.git")
local clue = require("mini.clue")
local jump = require("mini.jump")
local pick = require("mini.pick")
local align = require("mini.align")
local files = require("mini.files")
local icons = require("mini.icons")
local sessions = require("mini.sessions")
local surround = require("mini.surround")
local splitjoin = require("mini.splitjoin")
local bracketed = require("mini.bracketed")
local cursorword = require("mini.cursorword")
local statusline = require("mini.statusline")
local hipatterns = require("mini.hipatterns")
local indentscope = require("mini.indentscope")

ai.setup {
   silent = true,
}

git.setup()

clue.setup {
   triggers = {
      { mode = { "n", "x" }, keys = "<leader>" },

      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },

      { mode = "i", keys = "<C-x>" },

      { mode = { "n", "x" }, keys = "g" },

      { mode = { "n", "x" }, keys = "'" },
      { mode = { "n", "x" }, keys = "`" },

      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<C-r>" },

      { mode = "n", keys = "<C-w>" },

      { mode = { "n", "x" }, keys = "z" },
   },

   clues = {
      clue.gen_clues.square_brackets(),
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.marks(),
      clue.gen_clues.g(),
      clue.gen_clues.z(),
   },
   window = {
      delay = 250,
   },
}

jump.setup {
   silent = true,
}

pick.setup {
   options = {
      content_from_bottom = true,
      use_cache = true
   }
}

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Pick files" })
vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Pick buffers" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Pick through grep" })
vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic, { desc = "Pick diagnostics" })
vim.keymap.set("n", "<leader>fl", MiniExtra.pickers.lsp, { desc = "Pick lsp symbols" })
vim.keymap.set("n", "<leader>fm", MiniExtra.pickers.marks, { desc = "Pick marks" })

align.setup()

files.setup {
   windows = {
      preview = true
   }
}

vim.keymap.set("n", "<leader>-", MiniFiles.open, { desc = "Open files" })
vim.keymap.set("n", "<leader>_", function()
   MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open files in buffer directory" })

icons.setup()

sessions.setup {
   autoread = true,
}

surround.setup {
   search_method = "cover_or_next",
   silent = true,
}

splitjoin.setup()

bracketed.setup {
   silent = true,
}

cursorword.setup()

statusline.setup()

hipatterns.setup {
   highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
   },
}

indentscope.setup()
