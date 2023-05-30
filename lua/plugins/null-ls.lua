return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = "go",
        enabled = true,
        config = function()
            local null_ls = require("null-ls")
            local opts = {
                autostart = true,
                filetypes = { "go" },
                sources = {
                    -- null_ls.builtins.formatting.gofumpt, -- 更严格的格式化
                    null_ls.builtins.formatting.goimports_reviser, -- 导入顺序的支持
                    null_ls.builtins.formatting.gofmt,
                    -- null_ls.builtins.formatting.goimports,
                    -- null_ls.builtins.golines,
                },
                -- on_attach = function(client, bufnr)
                --     if client.supports_method("textDocument/formatting") then
                --         vim.api.nvim_clear_autocmds({
                --             group = augroup,
                --             buffer = bufnr,
                --         })
                --         vim.api.nvim_create_autocmd("BufWritePre", {
                --             group = augroup,
                --             buffer = bufnr,
                --             callback = function()
                --                 vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 4000 })
                --             end,
                --         })
                --     end
                -- end,
            }
            null_ls.setup(opts)
        end
    }
}
