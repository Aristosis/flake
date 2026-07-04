return {
   fuzzy = {
      implementation = "prefer_rust"
      -- implementation = "lua",
      -- prebuilt_binaries = { force_version = "v1.6.0" },
   },
   signature = { enabled = true },
   completion = {
      menu = {
         draw = {
            columns = {
               { "kind_icon", "label", "label_description", gap = 1 },
            },
            padding = { 0, 1 },
            components = {
               kind_icon = {
                  text = function(ctx)
                     return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
                  end,
               },
               kind = {},
            },
         },
      },
   },
}
