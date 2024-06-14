return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
   {
     "neovim/nvim-lspconfig",
     config = function()
       require("nvchad.configs.lspconfig").defaults()
       require "configs.lspconfig"
     end,
   },
  
   {
   	"williamboman/mason.nvim",
   	opts = {
   		ensure_installed = { %LSP% },
   	},
   },
  
   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = { %TREESITTER% },
   	},
   },
}
