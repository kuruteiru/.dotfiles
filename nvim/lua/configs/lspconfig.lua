require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
	"pyright",
	"clangd",
	"gopls",
	"eslint",
	"html",
	"jsonls",
	"cssls",
	"marksman",
	"sqls",
	"csharp_ls"

	-- "css-variables-language-server",
	-- "docker-compose-language-service",
	-- "dockerfile-language-server",
	-- "lua-language-server",
	-- "cmake-language-server",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	}
end
