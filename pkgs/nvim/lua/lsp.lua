require('spellsitter').setup{
enable = true,
}
require("project_nvim").setup {}
require('telescope').load_extension('projects')
require('neogen').setup {}
require("lsp_signature").setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  })
-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
-- REQUIRED - you must specify a snippet engine
expand = function(args)
vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
end,
},
mapping = {
['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
['<C-e>'] = cmp.mapping({
i = cmp.mapping.abort(),
c = cmp.mapping.close(),
}),
['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
},
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
{ name = 'vsnip' }, -- For vsnip users.
-- { name = 'luasnip' }, -- For luasnip users.
-- { name = 'ultisnips' }, -- For ultisnips users.
-- { name = 'snippy' }, -- For snippy users.
}, {
{ name = 'buffer' },
})
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
{ name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
{ name = 'path' }
}, {
{ name = 'cmdline' }
})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pyright'].setup {
capabilities = capabilities
}
require'lspconfig'.bashls.setup{}
require'lspconfig'.sumneko_lua.setup{
cmd = { "lua-language-server" }
}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.tsserver.setup{
    cmd={"typescript-language-server", "--stdio"},
}
require'lspconfig'.clangd.setup{
    cmd = {"clangd", "--background-index", "--log=verbose", "--clang-tidy", "--header-insertion=iwyu"}
}
require'lspconfig'.rnix.setup{}
