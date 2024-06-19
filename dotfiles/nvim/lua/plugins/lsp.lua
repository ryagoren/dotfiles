return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      {'mrcjkb/rustaceanvim', version='^4', lazy=false},
      "stevearc/conform.nvim",
    },
    config = function()
      require("neodev").setup {}

     local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

	local lspconfig = require "lspconfig"
	local servers = {
		bashls=true,
	}

     require("mason").setup()
      local ensure_installed = {}
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

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
	      desc='lspa', 
	      callback=function(ev)
		      vim.bo[ev.buf].omnifunc='v:lua.vim.lsp.omnifunc'
		      local opts={buffer=ev.buf}
		      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

		      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

		      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		      vim.keymap.set('n', '<leader>wl', function()
			      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		      end, opts)
		      vim.keymap.set({'n', 'v'}, '<space>a', vim.lsp.buf.code_action, opts)
		      vim.keymap.set('n', '<space>f', function()
			      vim.lsp.buf.format{async=true}
		      end, opts)


	      end
      })

      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

      require("conform").setup {}
      vim.api.nvim_create_autocmd("BufWritePre", {
	      callback = function(args)
		      require("conform").format {
			      bufnr = args.buf,
			      lsp_fallback = true,
			      quiet = true,
		      }
	      end,
      })
    end,
  },
}


