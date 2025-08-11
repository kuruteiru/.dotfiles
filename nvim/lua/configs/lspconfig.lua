require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp     = require "nvchad.configs.lspconfig"

local servers   = {
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
	-- "ltex",
	"lua_ls",
	"vuels",
	"bashls"
}
--
--
-- lspconfig.ts_ls.setup {
-- 	filetypes    = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "html" },
-- 	on_attach    = nvlsp.on_attach,
-- 	on_init      = nvlsp.on_init,
-- 	capabilities = nvlsp.capabilities,
-- }
--
-- lspconfig.html.setup {
-- 	filetypes    = { "html" },
-- 	init_options = {
-- 		embeddedLanguages = { css = true, javascript = true, },
-- 		provideFormatter = false,
-- 	},
-- 	on_attach    = nvlsp.on_attach,
-- 	on_init      = nvlsp.on_init,
-- 	capabilities = nvlsp.capabilities,
-- }

for _, name in ipairs(servers) do
	lspconfig[name].setup {
		on_attach    = nvlsp.on_attach,
		on_init      = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	}
end
