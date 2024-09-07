return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/neodev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim",   opts = {} },
            { 'mrcjkb/rustaceanvim', version = '^4', lazy = false },
            "stevearc/conform.nvim",
            "b0o/SchemaStore.nvim",

        },
        config = function()
            require("neodev").setup {}

            local capabilities = nil
            if pcall(require, "cmp_nvim_lsp") then
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            end

            local lspconfig = require "lspconfig"
            local servers = {
                bashls = true,
                lua_ls = true,
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },
                clangd = {
                    cmd = { "clangd", "--background-index", "--enable-config"},
                    filetypes = { "c", "cpp" },
                    root_dir = function(fname)
                        return lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname) or
                            vim.fn.getcwd()
                    end,
                },
            }

            require("mason").setup()

            for name, config in pairs(servers) do
                if config == true then
                    config = {}
                end
                config = vim.tbl_deep_extend("force", {}, {
                    capabilities = capabilities,
                }, config)

                lspconfig[name].setup(config)
            end


            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'lspa',
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<sK>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end
            })

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

            local function setup_cmake_compile_commands()
                local function on_vim_enter()
                    if vim.fn.filereadable('CMakeLists.txt') == 1 then
                        local build_dir = 'build'
                        if vim.fn.isdirectory(build_dir) == 0 then
                            vim.fn.mkdir(build_dir, 'p')
                        end
                        if vim.fn.filereadable(build_dir .. '/compile_commands.json') == 0 then
                            vim.fn.system('cmake -S . -B ' .. build_dir)
                        end
                        if vim.fn.filereadable('compile_commands.json') == 0 then
                            vim.fn.system('ln -s ' .. build_dir .. '/compile_commands.json compile_commands.json')
                        end
                    end
                end
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = on_vim_enter,
                    group = vim.api.nvim_create_augroup("CMakeSetup", { clear = true }),
                })
            end
            setup_cmake_compile_commands()
        end,
    },
}
