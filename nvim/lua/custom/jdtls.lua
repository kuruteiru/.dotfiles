local M = {}

function M.setup()
  local jdtls = require("jdtls")
  local home = os.getenv("HOME")
  local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"

  -- Find the Equinox launcher JAR
  local jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", jar,
      "-configuration", jdtls_path .. "/config_linux",
      "-data", vim.fn.stdpath("data") ..
        "/jdtls_workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
    },

    root_dir = require("jdtls.setup").find_root({
      ".git", "mvnw", "gradlew", "pom.xml", "build.gradle",
    }),

    capabilities = require("nvchad.configs.lspconfig").capabilities,
    on_attach = require("nvchad.configs.lspconfig").on_attach,
  }

  jdtls.start_or_attach(config)
end

return M
