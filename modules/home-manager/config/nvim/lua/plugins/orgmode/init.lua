local org = _G.org
return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  opts = {
    org_agenda_files       = org .. "**/*",
    org_default_notes_file = org .. "/inbox.org",
    org_capture_templates  = require("plugins.orgmode.templates")
  }
}
