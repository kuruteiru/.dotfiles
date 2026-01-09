local M = {}

function M.setup()
	local jdtls = require("jdtls")

	-- Define the setup logic in a reusable function
	local function load_jdtls()
		local home = os.getenv("HOME")
		local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
		local jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

		-- 1. Determine the project root (WebCrawler)
		local root_markers = { ".git", "mvnw", "gradlew" }
		local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()

		-- 2. Define the workspace directory based on the project name
		local project_name = vim.fn.fnamemodify(root_dir, ":t")
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls_workspace/" .. project_name

		-- 3. Fix the "_java.reloadBundles" error
		local extendedClientCapabilities = jdtls.extendedClientCapabilities
		extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

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
				"-data", workspace_dir,
			},
			root_dir = root_dir,

			-- This fixes the error about reloadBundles
			init_options = {
				extendedClientCapabilities = extendedClientCapabilities,
			},

			capabilities = require("nvchad.configs.lspconfig").capabilities,
			on_attach = require("nvchad.configs.lspconfig").on_attach,
		}

		-- This command attaches the client to the current buffer
		jdtls.start_or_attach(config)
	end

	-- 4. Create an Autocmd so this runs for EVERY Java file, not just the first one
	local au_group = vim.api.nvim_create_augroup("JdtlsSetup", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = load_jdtls,
		group = au_group,
	})

	-- 5. Run it immediately for the current buffer (since the FileType event might have already fired)
	load_jdtls()
end

return M

-- print("JDTLS root_dir:", config.root_dir)
