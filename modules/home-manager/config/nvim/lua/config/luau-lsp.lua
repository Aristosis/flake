local function rojo_project()
   return vim.fs.root(0, function(name)
      return name:match(".+%.project%.json$")
   end)
end

return {
   platform = {
      type = rojo_project() and "roblox" or "standard",
   },
   types = {
      roblox_security_level = "PluginSecurity",
   },
   sourcemap = {
      enabled = true,
      autogenerate = true,
      rojo_project_file = "default.project.json",
      sourcemap_file = "sourcemap.json",
   },
   plugin = {
      enabled = true,
      port = 3667,
   },
   fflags = {
      enable_new_solver = true,
   },
   server = {
      crash_reporting = false,
   },
}
