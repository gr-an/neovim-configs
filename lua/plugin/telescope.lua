local actions = require("telescope.actions")

local fb_actions = require "telescope._extensions.file_browser.actions"
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  },
  extensions = {
    file_browser = {
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = false,
      respect_gitignore = false,
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true, mode = true },
      hijack_netrw = true,
      use_fd = true,
      git_status = true,
      -- mappings = {
        -- ["i"] = {
        --   ["<A-c>"] = fb_actions.create,
        --   ["<S-CR>"] = fb_actions.create_from_prompt,
        --   ["<A-r>"] = fb_actions.rename,
        --   ["<A-m>"] = fb_actions.move,
        --   ["<A-y>"] = fb_actions.copy,
        --   ["<A-d>"] = fb_actions.remove,
        --   ["<C-o>"] = fb_actions.open,
        --   ["<C-g>"] = fb_actions.goto_parent_dir,
        --   ["<C-e>"] = fb_actions.goto_home_dir,
        --   ["<C-w>"] = fb_actions.goto_cwd,
        --   ["<C-t>"] = fb_actions.change_cwd,
        --   ["<C-f>"] = fb_actions.toggle_browser,
        --   ["<C-h>"] = fb_actions.toggle_hidden,
        --   ["<C-s>"] = fb_actions.toggle_all,
        --   ["<bs>"] = fb_actions.backspace,
        -- },
        -- ["n"] = {
        --   ["c"] = fb_actions.create,
        --   ["r"] = fb_actions.rename,
        --   ["m"] = fb_actions.move,
        --   ["y"] = fb_actions.copy,
        --   ["d"] = fb_actions.remove,
        --   ["o"] = fb_actions.open,
        --   ["g"] = fb_actions.goto_parent_dir,
        --   ["e"] = fb_actions.goto_home_dir,
        --   ["w"] = fb_actions.goto_cwd,
        --   ["t"] = fb_actions.change_cwd,
        --   ["f"] = fb_actions.toggle_browser,
        --   ["h"] = fb_actions.toggle_hidden,
        --   ["s"] = fb_actions.toggle_all,
        -- },
      -- },
    },
  },
})

require("telescope").load_extension "file_browser"

vim.api.nvim_set_keymap(
  "n",
  "<Space>l",
  ":Telescope file_browser initial_mode=normal<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Space>L",
  ":Telescope file_browser path=%:p:h select_buffer=true initial_mode=normal<CR>",
  { noremap = true }
)

local builtin = require('telescope.builtin')


local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')

local function read_folders_from_file(filepath)
  local folders = {}
  local file = io.open(filepath, 'r')
  if not file then
    print("Error: Unable to open the file.")
    return folders
  end

  for line in file:lines() do
    table.insert(folders, line)
  end
  file:close()
  return folders
end

local function open_folder_picker()
  local filepath = "/Users/vahagn/.config/projects"
  local folders = read_folders_from_file(filepath)

  pickers.new({}, {
    prompt_title = 'Folder Picker',
    finder = finders.new_table {
      results = folders,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local folder_path = selection.value
        vim.cmd("cd " .. folder_path)
        vim.cmd("Telescope find_files")
      end)

      return true
    end,
  }):find()
end

vim.keymap.set('n', '<Space>p', open_folder_picker, {})
vim.keymap.set('n', '<Space>P', ":e /Users/vahagn/.config/projects<CR>", {})

vim.keymap.set('n', '<Space>f', builtin.find_files, {})
vim.keymap.set('n', '<Space>g', builtin.live_grep, {})
vim.keymap.set('n', '<Space>d', builtin.quickfix, {})
vim.keymap.set('n', '<Space>m', builtin.man_pages, {})
vim.keymap.set('n', '<Space>x', builtin.commands, {})
vim.keymap.set('n', '<Space>s', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<Space>b', builtin.git_branches, {})
vim.keymap.set('n', '<Space>c', builtin.current_buffer_fuzzy_find, {})

vim.keymap.set('n', '<Space><Space>', ":Telescope<CR>", {})

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

vim.keymap.set('n', 'mv', harpoon_ui.toggle_quick_menu, {})
vim.keymap.set('n', 'mf', function() harpoon_ui.nav_file(1) end, {})
vim.keymap.set('n', 'md', function() harpoon_ui.nav_file(2) end, {})
vim.keymap.set('n', 'ms', function() harpoon_ui.nav_file(3) end, {})
vim.keymap.set('n', 'ma', function() harpoon_ui.nav_file(4) end, {})
vim.keymap.set('n', 'mc', harpoon_mark.add_file, {})
