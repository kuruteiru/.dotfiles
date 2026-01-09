return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css", "c_sharp", "c", "cpp", "go", "javascript", "python", "rust",
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
