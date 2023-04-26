local cmp = require("cmp")
local luasnip = require("luasnip")

local kind_icons = {
  -- Text = "",
  -- Method = "",
  -- Function = "",
  -- Constructor = "",
  -- Field = "",
  -- Variable = "",
  -- Class = "ﴯ",
  -- Interface = "",
  -- Module = "",
  -- Property = "ﰠ",
  -- Unit = "",
  -- Value = "",
  -- Enum = "",
  -- Keyword = "",
  -- Snippet = "",
  -- Color = "",
  -- File = "",
  -- Reference = "",
  -- Folder = "",
  -- EnumMember = "",
  -- Constant = "",
  -- Struct = "",
  -- Event = "",
  -- Operator = "",
  -- TypeParameter = ""

  Text = "...",
  Method = "M()",
  Function = "f()",
  Constructor = "New",
  Field = "[f]",
  Variable = "var",
  Class = "C{}",
  Interface = "I{}",
  Module = "[M]",
  Property = "(p)",
  Unit = "un.",
  Value = "123",
  Enum = "E{}",
  Keyword = "key",
  Snippet = "</>",
  Color = "rgb",
  File = "<f>",
  Reference = "& r",
  Folder = "<d>",
  EnumMember = "E.B",
  Constant = "VAR",
  Struct = "S{}",
  Event = "*ev",
  Operator = "+-=",
  TypeParameter = "<T>"
}

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- This concatonates the icons with the name of the item kind
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.kind = kind_icons[vim_item.kind]

      vim_item.menu = ({
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        luasnip = "[snp]",
        nvim_lua = "[lua]",
        latex_symbols = "[tex]",
      })[entry.source.name]
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>je', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>jw', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Change later
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>dd', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>df', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>de', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>dj', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>dh', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>dp', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>dP', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>do', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>dt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>dn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>dk', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>dr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>ds', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("mason").setup()
require("mason-lspconfig").setup()


local lspconfig = require "lspconfig"
local servers = {
  "html",
  "marksman",
  "tailwindcss",
  "yamlls",
  "pyright",
  "tsserver",
  "rust_analyzer",
  "sqlls",
  "lua_ls",
  "eslint",
  "astro",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
