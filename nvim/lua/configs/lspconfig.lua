require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp     = require "nvchad.configs.lspconfig"

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
  -- "ltex",
  "lua_ls",
  "vuels",
  "bashls",
  "angularls",
  -- "jdtls"
}

for _, name in ipairs(servers) do
  lspconfig[name].setup {
    on_attach    = nvlsp.on_attach,
    on_init      = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
