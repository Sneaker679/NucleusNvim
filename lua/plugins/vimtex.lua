return {
    "lervag/vimtex",
    init = function()
        -- Disable automatic quickfix opening
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = "aux", -- create a directory called aux that will contain all the auxiliary files
        }
        vim.g.vimtex_view_method = "zathura"
    end,
    config = function()
        -- Removes synctex files when leaving neovim
        vim.api.nvim_create_autocmd("VimLeavePre", {
            pattern = "*.tex",
            callback = function()
                local texfile = vim.fn.expand("%:p:r")
                local synctex_file = texfile .. ".synctex.gz"
                if vim.fn.filereadable(synctex_file) == 1 then
                    vim.fn.delete(synctex_file)
                end
            end,
        })
    end,
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
}
