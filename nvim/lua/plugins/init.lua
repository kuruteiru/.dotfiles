return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig" -- we will rewrite this next
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
        "c_sharp", "c", "go", "javascript", "python"
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("custom.jdtls").setup()
    end
  }
}

-- RETURN {
-- 	{
-- 		"STEVEARC/CONFORM.NVIM",
-- 		-- EVENT = 'BUFWRITEPRE', -- UNCOMMENT FOR FORMAT ON SAVE
-- 		OPTS = REQUIRE "CONFIGS.CONFORM",
-- 	},
--
-- 	-- THESE ARE SOME EXAMPLES, UNCOMMENT THEM IF YOU WANT TO SEE THEM WORK!
-- 	{
-- 		"NEOVIM/NVIM-LSPCONFIG",
-- 		CONFIG = FUNCTION()
-- 			REQUIRE "CONFIGS.LSPCONFIG"
-- 		END,
-- 	},
--
-- 	{
-- 		"NVIM-TREESITTER/NVIM-TREESITTER",
-- 		OPTS = {
-- 			ENSURE_INSTALLED = {
-- 				"VIM",
-- 				"LUA",
-- 				"VIMDOC",
-- 				"HTML",
-- 				"CSS",
-- 				"C_SHARP",
-- 				"C",
-- 				"GO",
-- 				"JAVASCRIPT",
-- 				"PYTHON"
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"MFUSSENEGGER/NVIM-JDTLS",
-- 		FT = { "JAVA" },
-- 		CONFIG = FUNCTION()
-- 			LOCAL JDTLS = REQUIRE("JDTLS")
--
-- 			LOCAL HOME = OS.GETENV("HOME")
-- 			LOCAL JDTLS_PATH = HOME .. "/.LOCAL/SHARE/NVIM/MASON/PACKAGES/JDTLS"
--
-- 			LOCAL CONFIG = {
-- 				CMD = {
-- 					"JAVA",
-- 					"-DECLIPSE.APPLICATION=ORG.ECLIPSE.JDT.LS.CORE.ID1",
-- 					"-DOSGI.BUNDLES.DEFAULTSTARTLEVEL=4",
-- 					"-DECLIPSE.PRODUCT=ORG.ECLIPSE.JDT.LS.CORE.PRODUCT",
-- 					"-DLOG.PROTOCOL=TRUE",
-- 					"-DLOG.LEVEL=ALL",
-- 					"-XMX1G",
-- 					"--ADD-MODULES=ALL-SYSTEM",
-- 					"--ADD-OPENS", "JAVA.BASE/JAVA.UTIL=ALL-UNNAMED",
-- 					"--ADD-OPENS", "JAVA.BASE/JAVA.LANG=ALL-UNNAMED",
-- 					"-JAR", JDTLS_PATH .. "/PLUGINS/ORG.ECLIPSE.EQUINOX.LAUNCHER_*.JAR",
-- 					"-CONFIGURATION", JDTLS_PATH .. "/CONFIG_LINUX",
-- 					"-DATA", VIM.FN.STDPATH("DATA") ..
-- 				"/JDTLS_WORKSPACE/" .. VIM.FN.FNAMEMODIFY(VIM.FN.GETCWD(), ":P:H:T")
-- 				},
-- 				ROOT_DIR = REQUIRE("JDTLS.SETUP").FIND_ROOT({ ".GIT", "MVNW", "GRADLEW", "POM.XML", "BUILD.GRADLE" }),
-- 				CAPABILITIES = REQUIRE("NVCHAD.CONFIGS.LSPCONFIG").CAPABILITIES,
-- 				ON_ATTACH = REQUIRE("NVCHAD.CONFIGS.LSPCONFIG").ON_ATTACH,
-- 			}
--
-- 			JDTLS.START_OR_ATTACH(CONFIG)
-- 		END
-- 	}
-- }
