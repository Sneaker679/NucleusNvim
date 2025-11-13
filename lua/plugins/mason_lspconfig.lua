return {
    "mason-org/mason-lspconfig.nvim",
	opts = {
	    ensure_installed = {
	        "lua_ls",
	        "pyright",
	        "ts_ls",
	        "rust_analyzer",
	        "clangd"
	    },
	},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
