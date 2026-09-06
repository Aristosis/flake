vim.pack.add {
   { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
   { src = "https://github.com/stevearc/oil.nvim" },
}

require("blink.cmp").setup()

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

