local gh = "https://github.com/"

vim.pack.add {
   { src = gh .. "sainnhe/gruvbox-material" },
   { src = gh .. "3rd/image.nvim" },
   { src = gh .. "NMAC427/guess-indent.nvim" },
   { src = gh .. "nvim-tree/nvim-web-devicons" },
   { src = gh .. "stevearc/conform.nvim" },
   { src = gh .. "mfussenegger/nvim-lint" },
   { src = gh .. "mason-org/mason.nvim" },
   { src = gh .. "mason-org/mason-lspconfig.nvim" },
   { src = gh .. "neovim/nvim-lspconfig" },
   { src = gh .. "nvim-treesitter/nvim-treesitter-context" },
   { src = gh .. "nvim-treesitter/nvim-treesitter", version = "main" },
   { src = gh .. "Saghen/blink.cmp", version = vim.version.range("1*") },
   { src = gh .. "nvim-mini/mini.nvim", version = "main" },
}

vim.api.nvim_create_autocmd("BufReadPost", {
   once = true,
   callback = function()
      require("guess-indent").setup()
      require("mini.hipatterns").setup(require("config.hipatterns"))
      require("mini.sessions").setup { autoread = true }
      require("mini.surround").setup()
      require("mini.ai").setup()
      require("mini.splitjoin").setup()
      require("conform").setup(require("config.conform"))
      require("lint").linters_by_ft = _G.linters_by_ft
      require("image").setup {
         backend = "sixel",
      }
      require("treesitter-context").setup {
         mode = "cursor",
         max_lines = 1,
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
         callback = function()
            require("lint").try_lint()
         end,
      })
   end,
})

require("nvim-web-devicons").setup()
require("mini.statusline").setup()
require("mini.pick").setup {
   options = {
      content_from_bottom = true,
      use_cache = true,
   },
}
require("mini.files").setup { windows = { preview = true } }
require("blink.cmp").setup(require("config.blink"))
require("mason").setup()
require("mason-lspconfig").setup()

vim.o.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

---@diagnostic disable:undefined-global
---
local function open_files_in_buf_dir()
   ---@diagnostic disable-next-line:undefined-global
   MiniFiles.open(vim.api.nvim_buf_get_name(0))
end
local function open_files()
   ---@diagnostic disable-next-line:undefined-global
   MiniFiles.open(nil, true, { number = true, relativenumber = true })
end

local map = vim.keymap.set
map("n", "<leader>f", MiniPick.builtin.files, { noremap = true, silent = true })
map("n", "<leader>h", MiniPick.builtin.help, { noremap = true, silent = true })
map("n", "<leader>b", MiniPick.builtin.buffers, { noremap = true, silent = true })
map("n", "<C-/>", MiniPick.builtin.grep, { noremap = true, silent = true })
map("n", "<C-S-/>", MiniPick.builtin.grep_live, { noremap = true, silent = true })
map("n", "<C-/>", MiniPick.builtin.grep, { noremap = true, silent = true })
map("n", "<C-S-/>", MiniPick.builtin.grep_live, { noremap = true, silent = true })
map("n", "<leader>-", open_files, { noremap = true, silent = true })
map("n", "<leader>_", open_files_in_buf_dir, { noremap = true, silent = true })

---@diagnostic enable:undefined-global
