return {
   "otavioschwanck/arrow.nvim",
   config = function()
      arrow = require("arrow")
      arrow.setup {
        leader_key = "<M-m>",
        buffer_leader_key = "\\",
        separate_by_branch = true,
      }
   end
}
