local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'additionalTextEdits',
    'detail',
    'documentation',
  }
}

require'lspconfig'.clangd.setup {
    cmd = {DATA_PATH .. "/lspinstall/cpp/clangd/bin/clangd", "--background-index", "--completion-style=detailed"},
    on_attach = require'lsp'.common_on_attach,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = O.lang.clang.diagnostics.virtual_text,
            signs = O.lang.clang.diagnostics.signs,
            underline = O.lang.clang.diagnostics.underline,
            update_in_insert = true

        })
    }
}
