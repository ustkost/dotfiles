return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "clangd", "gopls" },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			map("n", "gd", vim.lsp.buf.definition, "Go to definition")
			map("n", "K", vim.lsp.buf.hover, "Hover")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
			map("n", "gr", vim.lsp.buf.references, "References")
			map("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, "Format")
			map("n", "gl", vim.diagnostic.open_float, "Show diagnostics under cursor")
		end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local servers = { "lua_ls", "clangd", "gopls" }
    for _, server in ipairs(servers) do
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  end,
}

