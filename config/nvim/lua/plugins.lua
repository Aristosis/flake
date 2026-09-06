vim.pack.add {
   { src = "https://github.com/nvim-tree/nvim-web-devicons" },

   { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
   { src = "https://github.com/stevearc/oil.nvim" },
   { src = "https://github.com/ibhagwan/fzf-lua" },
   { src = "https://github.com/kylechui/nvim-surround" },

   { src = "https://github.com/lewis6991/gitsigns.nvim" }
}

require("blink.cmp").setup()
require("gitsigns").setup()
require("nvim-surround").setup()

local oil = require("oil")
oil.setup {
   default_file_explorer = true,
   skip_confirm_for_simple_edits = true,
   float = { border = "single", max_width = 0.8, max_height = 0.8 },
}

vim.keymap.set("n", "<leader>-", function()
   oil.toggle_float(nil, { preview = {} })
end)

vim.keymap.set("n", "<leader>_", function()
   oil.toggle_float(vim.fn.getcwd(), { preview = {} })
end)

local fzf = require("fzf-lua")
fzf.setup {
   fzf_opts = { ["--color"] = "bg:-1,bg+:-1,gutter:-1" }
}

vim.keymap.set(
   "n",
   "<leader><leader>",
   function()
      if not fzf.git_files() then fzf.files() end
   end
)

vim.keymap.set(
   "n",
   "<leader>m",
   fzf.marks
)

vim.keymap.set(
   "n",
   "<leader>f",
   fzf.live_grep
)

vim.keymap.set(
   "n",
   "<leader>f",
   fzf.live_grep
)
