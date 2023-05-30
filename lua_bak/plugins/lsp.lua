return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        config = function()
            require("mason").setup {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    },
                    border = "rounded",
                }, 
                -- ensure_installed = {
                --     "gopls", 
                --     "lua_ls"
                -- }, 
            }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    -- "gopls", 
                }
            })
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name)  -- default handler (optional)
                    local lsp = require("lspconfig")
                    local capabilities = require("cmp_nvim_lsp").default_capabilities()

                    lsp[server_name].setup {
                        capabilities = capabilities,
                    }
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function ()
                --     require("rust-tools").setup {}
                -- end
                
                -- ["gopls"] = function()
                --     require("lspconfig").gopls.setup {
                --         on_attach = require("lsp_signature").on_attach(), 
                --         capabilities = require("cmp_nvim_lsp").default_capabilities(), 
                --         cmd = {"gopls"}, 
                --         filetypes = {"go", "gomod", "gowork", "gotmpl"}, 
                --         root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"), 
                --     }
                -- end, 
            }
        end,
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        event = "VeryLazy",
        config = function() require('lsp/handler')() end,
    },

    {
        'tami5/lspsaga.nvim',
        event = "VeryLazy",
        config = function()
            require('lspsaga').init_lsp_saga {
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                border_style = "round",
                code_action_prompt = {
                    enable = false
                }
            }
        end
    },
    {
        "kosayoda/nvim-lightbulb", -- code actio
        config = function(_, _)
            require('nvim-lightbulb').setup({
                autocmd = { enabled = true }
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
    }
}

-- config:
-- event: VeryLazy/插件使用时候加载
