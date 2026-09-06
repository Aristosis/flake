vim.pack.add {
   { src = "https://github.com/nvim-tree/nvim-web-devicons" },

   { src = "https://github.com/stevearc/oil.nvim" },
   { src = "https://github.com/stevearc/conform.nvim" },
   { src = "https://github.com/ibhagwan/fzf-lua" },
   { src = "https://github.com/kylechui/nvim-surround" },
   { src = "https://github.com/neovim/nvim-lspconfig" },
   { src = "https://github.com/lewis6991/gitsigns.nvim" },
   { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
}

require("nvim-surround").setup()
require("gitsigns").setup()

require("conform").setup {
   format_on_save = true,
   formatters_by_ft = {
      lua = { "stylua" },
   },
}

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
   fzf_opts = { ["--color"] = "bg:-1,bg+:-1,gutter:-1" },
}

vim.keymap.set("n", "<leader><leader>", fzf.files)

vim.keymap.set("n", "<leader>m", fzf.marks)

vim.keymap.set("n", "<leader>f", fzf.live_grep)

vim.schedule(function()
   require("obsidian").setup {
      legacy_commands = false,
      ui = {
         enable = false,
      },
      workspaces = {
         {
            name = "ari",
            path = "/home/ari/media/hdd/documents/ari",
         },
      },
   }
   vim.keymap.set("n", "<leader>o", vim.cmd.Obsidian)
end)

