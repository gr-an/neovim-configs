local alpha = require"alpha"
local dashboard = require"alpha.themes.dashboard"
dashboard.section.header.val = "foo"
dashboard.section.buttons.val = {
    dashboard.button( "e", "+ new" , ":ene <BAR> startinsert <cr>"),
    dashboard.button( "q", "- quit" , ":qa <cr>"),
    dashboard.button( "c", "! config" , ":cd ~/.config/nvim | :e init.lua <cr>"),
    dashboard.button( "l", "& lazy" , ":Lazy <cr>"),

}
local handle = io.popen("fortune")
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune
alpha.setup(dashboard.opts)
