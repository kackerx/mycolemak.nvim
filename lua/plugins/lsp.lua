return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        enabled = true,
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
        enabled = true,
        event = "VeryLazy",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                }
            })
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
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

                ["gopls"] = function()
                    require("lspconfig").gopls.setup {
                        autostart = true,
                        --on_attach = require("lsp_signature").on_attach(),
                        -- on_attach = function(client, bufnr)
                            -- 自动调整package的导入顺序
                            -- client.resolved_capabilities.document_formatting = true
                        -- end, 
                        capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        cmd = { "gopls" },
                        filetypes = { "go", "gomod", "gowork", "gotmpl" },
                        root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
                        settings = {
                            gopls = {
                                completeUnimported = true,
                                usePlaceholders = true,
                                analyses = {
                                    unusedparams = true,
                                }
                            }
                        },
                    }
                end,
            }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        enabled = true,
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        event = "BufReadPre",
        config = function() require('lsp/handler')() end,
    },

    {
        'tami5/lspsaga.nvim',
        enabled = false,
        event = "VeryLazy",
        config = function()
            require('lspsaga').init_lsp_saga {
                error_sign = '',
                warn_sign = '',
                hint_sign = '',
                infor_sign = '',
                border_style = "round",
                code_action_prompt = {
                    enable = true,
                    sign = true,
                    sign_priority = 40,
                    virtual_text = false,
                },
            }
        end
    },
    {
        "kosayoda/nvim-lightbulb", -- code actio
        enabled = false,
        event = "VeryLazy",
        config = function(_, _)
            require('nvim-lightbulb').setup({
                autocmd = { enabled = true }
            })
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        enabled = true,
        event = "BufReadPre",
        config = function()
            require "lsp_signature".setup({
                debug = false,                                              -- set to true to enable debug logging
                log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
                -- default is  ~/.cache/nvim/lsp_signature.log
                verbose = false,                                            -- show debug line number

                bind = true,                                                -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 10,                                             -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                floating_window = true,                -- show hint in a floating window, set to false for virtual text only mode

                floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
                -- will set to true when fully tested, set to false will use whichever side has more space
                -- this setting will be helpful if you do not want the PUM and floating win overlap

                floating_window_off_x = 0, -- adjust float windows x position.
                floating_window_off_y = 0, -- adjust float windows y position.


                fix_pos = false,                              -- set to true, the floating window will not auto-close until finish all parameters
                hint_enable = true,                           -- virtual hint enable
                hint_prefix = "🐼 ",                        -- Panda for parameter
                hint_scheme = "String",
                hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                max_height = 12,                              -- max height of signature floating_window, if content is more than max_height, you can scroll down
                -- to view the hiding contents
                max_width = 80,                               -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "rounded"                        -- double, rounded, single, shadow, none
                },

                always_trigger = false,   -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

                auto_close_after = nil,   -- autoclose signature float win after x sec, disabled if nil.
                extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                zindex = 200,             -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

                padding = '',             -- character to pad on left and right of signature can be ' ', or '|'  etc

                transparency = nil,       -- disabled by default, allow floating win transparent value 1~100
                shadow_blend = 36,        -- if you using shadow as border use this set the opacity
                shadow_guibg = 'Black',   -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                timer_interval = 200,     -- default timer check interval set to lower value if you want to reduce latency
                toggle_key = '<M-x>'      -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
            })
        end
    }
}

-- config:
-- event: VeryLazy/插件使用时候加载
