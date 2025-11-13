return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup()
        -- Auto-quit Neovim if nvim-tree is the last window
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
                    vim.cmd("quit")
                end
            end,
        })
    end,
}

