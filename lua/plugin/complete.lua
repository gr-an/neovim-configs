local cmp = require('cmp')
local luasnip = require('luasnip')

local kind_icons = {
  -- Text = '',
  -- Method = '',
  -- Function = '',
  -- Constructor = '',
  -- Field = '',
  -- Variable = '',
  -- Class = 'ﴯ',
  -- Interface = '',
  -- Module = '',
  -- Property = 'ﰠ',
  -- Unit = '',
  -- Value = '',
  -- Enum = '',
  -- Keyword = '',
  -- Snippet = '',
  -- Color = '',
  -- File = '',
  -- Reference = '',
  -- Folder = '',
  -- EnumMember = '',
  -- Constant = '',
  -- Struct = '',
  -- Event = '',
  -- Operator = '',
  -- TypeParameter = ''

  Text = '...',
  Method = 'M()',
  Function = 'f()',
  Constructor = 'New',
  Field = '[f]',
  Variable = 'var',
  Class = 'C{}',
  Interface = 'I{}',
  Module = '[M]',
  Property = '(p)',
  Unit = 'un.',
  Value = '123',
  Enum = 'E{}',
  Keyword = 'key',
  Snippet = '</>',
  Color = 'rgb',
  File = '<f>',
  Reference = '& r',
  Folder = '<d>',
  EnumMember = 'E.B',
  Constant = 'VAR',
  Struct = 'S{}',
  Event = '*ev',
  Operator = '+-=',
  TypeParameter = '<T>'
}

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- This concatonates the icons with the name of the item kind
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.kind = kind_icons[vim_item.kind]

      vim_item.menu = ({
        buffer = '[buf]',
        nvim_lsp = '[lsp]',
        luasnip = '[snp]',
        nvim_lua = '[lua]',
        latex_symbols = '[tex]',
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
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
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
  local bufopts = { noremap = true, silent = false, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  -- vim.keymap.set('n', '<leader>dp', vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>dP', vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set('n', '<leader>do', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'ge', ':Telescope lsp_references theme=ivy<CR>', bufopts)
  vim.keymap.set('n', 'gj', ':Telescope lsp_implementations theme=ivy<CR>', bufopts)
  vim.keymap.set('n', 'gd', ':Telescope lsp_definitions theme=ivy<CR>', bufopts)

  vim.keymap.set('n', '#', vim.lsp.buf.format, bufopts)
  vim.keymap.set('v', '#', vim.lsp.buf.format, bufopts)
end

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
})

require('lspconfig').tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "rust" },
}

local signs = { Error = 'e', Warn = 'w', Hint = '?', Info = 'i' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  virtual_text = { prefix = '', spacing = 10 },
  severity_sort = true,
  float = {
    source = 'always',
  },
})

-- add border to lsp float windows
local _border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config {
  float = { border = _border }
}
