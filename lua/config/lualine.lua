require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
    section_separators = "",
    component_separators = "/",
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str) return str:sub(1, 1) end
      }
    },
    lualine_b = {
      "branch",
      "diff",
      "diagnostics",
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        path = 2
      }
    },
    lualine_z = { },
    lualine_y = { },
    lualine_x = { },
  },
  extensions = { "quickfix", "fugitive", "fzf" },
})
