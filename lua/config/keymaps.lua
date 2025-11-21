local Commands = require("config.commands")

-- Shows lsp hints
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- Go to next diagnostic (error/warning/info)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
-- Go to previous diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
-- Go to next error
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
-- Go to previous error
vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous error" })

-- Keymap to compile the makefile in the current directory or find the make file in the parent directories
vim.keymap.set('n', '<leader>m', Commands.MakeFile, { desc = "Compile Makefile in current file's dir" })

-- Runs python on the right
vim.keymap.set("n", "<leader>p", Commands.RunPython, { desc = "Run Python in terminal" })
vim.keymap.set("n", "<leader>P", Commands.ClosePython, { desc = "Close Python terminal" })

-- Open terminal in neovim
vim.keymap.set('n', '<leader>t', Commands.OpenTerminal, {desc = 'Open/Focus Terminal', noremap = true, silent = true,  })
vim.keymap.set('t', '<leader>t', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<leader>T', Commands.CloseTerminal, { desc = 'Close terminal' })

-- Strips whitespaces
vim.keymap.set("n", "<leader>S", ":StripWhitespace<CR>", { desc = "Strip whitespaces" })

-- Telescope keybinds
local Telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', Telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', Telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', Telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', Telescope.help_tags, { desc = 'Telescope help tags' })

-- Tree keybinds
vim.keymap.set("n", "<leader><S-Tab>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Tree" })
vim.keymap.set("n", "<leader><Tab>", Commands.FocusOrOpenTree, { desc = "Open/Focus File Tree" })

-- Other navigation shortcuts instead of crtl+W+arrow
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Increase/decrease window height
vim.keymap.set('n', '<A-j>', ':resize +5<CR>', { desc = 'Increase window height', silent=true })
vim.keymap.set('n', '<A-k>', ':resize -5<CR>', { desc = 'Decrease window height', silent=true })

-- Increase/decrease window width
vim.keymap.set('n', '<A-h>', ':vertical resize +5<CR>', { desc = 'Increase window width', silent=true })
vim.keymap.set('n', '<A-l>', ':vertical resize -5<CR>', { desc = 'Decrease window width', silent=true })

-- Move selected chun
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selected chunk up', silent=true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selected chunk down', silent= true })

---- Better escape using jk in insert, visual and terminal mode
--vim.keymap.set("i", "jk", "<ESC>", vim.default_opts)
--vim.keymap.set("t", "jk", "<C-\\><C-n>", vim.default_opts)
--vim.keymap.set("v", "jk", "<ESC>", vim.default_opts)

---- Go to limits
vim.keymap.set("n", "<leader>h", '0', { desc = "Move to max left" })
vim.keymap.set("n", "<leader>j", 'G', { desc = "Move to bottom" })
vim.keymap.set("n", "<leader>k", 'gg', { desc = "Move to beginning" })
vim.keymap.set("n", "<leader>l", 'g_', { desc = "Move to max right" })

-- Better indent
vim.keymap.set("v", "<", "<gv", vim.default_opts)
vim.keymap.set("v", ">", ">gv", vim.default_opts)

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dP', vim.default_opts)

-- Select everything
vim.keymap.set('n', '<leader>va', 'ggvG$', { desc = 'Select all (character-wise)', noremap = true, silent = true })
