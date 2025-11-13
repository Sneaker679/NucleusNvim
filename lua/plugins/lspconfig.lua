return {
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Common helper for defining configs
    local function define_config(server, opts)
      opts = opts or {}
      opts.capabilities = capabilities
      vim.lsp.config(server, opts)
    end

    -- Define configs
    define_config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    define_config("pyright")
    define_config("ts_ls")
    define_config("rust_analyzer")
    define_config("clangd")
    define_config("texlab")

    -- Enable servers
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("rust_analyzer")
    vim.lsp.enable("clangd")
    vim.lsp.enable("texlab")
  end,
}


