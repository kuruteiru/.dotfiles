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
	"csharp_ls",
	"ts_ls",
	"denols",
	"tailwindcss",
	"lua_ls",
	"bashls",
	"angularls",
	-- "vuels",
	-- "jdtls",
}

for _, name in ipairs(servers) do
	local cfg = vim.lsp.config[name]
	if cfg then
		cfg.on_attach    = nvlsp.on_attach
		cfg.on_init      = nvlsp.on_init
		cfg.capabilities = nvlsp.capabilities
		vim.lsp.enable(name)
	else
		vim.notify("LSP config not found for " .. name, vim.log.levels.WARN)
	end
end
