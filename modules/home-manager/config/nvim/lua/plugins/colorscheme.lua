return {
   -- "sainnhe/gruvbox-material",
   "alexvzyl/nordic.nvim",
   opts = {
      bold_keywords = true,
      transparent = {
         bg = true,
         float = false,
      },
   },
   config = function(_, opts)
      require("nordic").setup(opts)
      vim.cmd.colorscheme("nordic")
   end,
}
