return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "python", "lua", "bash", "javascript", "typescript",
        "json", "yaml", "html", "css", "cpp", "c", "markdown", "markdown_inline"
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
    end
}
