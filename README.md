# Neovim Configuration

This repository contains a modern Neovim setup written in Lua and managed with [lazy.nvim](https://github.com/folke/lazy.nvim).  
It provides a lightweight, modular environment with autocompletion, LSP integration, syntax highlighting, and useful UI enhancements. Keybinds were manually written to optimize a coding workflow.

---

## Features

- Plugin management with `lazy.nvim`
- Built-in LSP configuration via `mason` and `lspconfig`
- Autocompletion using `nvim-cmp`
- Syntax highlighting and folding with `treesitter`
- Fuzzy finding with `telescope.nvim`
- Statusline with `lualine`
- Tokyonight default color scheme (can be changed)
- LaTeX support through VimTeX
- Modular structure for easy customization

---

## Installation

1. **Backup your existing configuration**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Copy this configuration**
   ```bash
   git clone <this-repository-url> ~/.config/nvim
   ```

3. **Open Neovim**
   ```bash
   nvim
   ```
   All plugins will be installed automatically by `lazy.nvim` on the first launch. Close neovim then reopen it again to get the final installed version.

---

## Installing Language Servers

This configuration uses **Mason** to manage LSP servers.  
You can open the Mason interface with:

```
:Mason
```

From there, you can install servers interactively. However, **some servers (like Pyright in some cases)** must be installed manually using `npm` or `pip`.  
For example:

```bash
npm install -g pyright
```

Once installed, Mason and `mason-lspconfig` will automatically register the server with Neovim.

Refer to [nvim-lspconfig’s documentation](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for specific instructions.

---

## Customization

### init.lua
This is the main entry point for Neovim.  
It loads the plugin manager, applies base settings, and imports all other Lua modules under `lua/config` and `lua/plugins`.

You can edit `init.lua` to change global Neovim options, such as tabulation or the colorscheme.

Example snippet:
```lua
vim.cmd.colorscheme "tokyonight-night" -- Change the colorscheme here
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
```

### Keymaps
Custom keybindings are defined in `lua/config/keymaps.lua`. You can modify or add your own keybindings there. For example, this shortcut calls a function from the telescope plugin:

```lua
vim.keymap.set('n', '<leader>ff', Telescope.find_files, { desc = 'Telescope find files' })
```

As in the last example, a lot of keybinds use the `<leader>`, which is set to `space` by default. You can change this at the top of your `init.lua`. Furthermore, the `which-key` pluggin is installed, which allows you to view the keybinds dynamically when you try to use one in normal mode.

#### List of the keymaps

1. LSP and Diagnostics
- **`<leader>d`** — Show diagnostics under the cursor in a floating window.

2. Build and Run
- **`<leader>m`** — Compile the Makefile in the current file’s directory or its parents.
- **`<leader>p`** — Run the current Python file in a terminal split on the right.
- **`<leader>P`** — Close the active Python terminal.

3. Terminal
- **`<leader>t`** — Open or focus the terminal in Neovim.
- **`<leader>T`** — Close the terminal window.
- **In terminal mode:**  
  - **`<leader>t`** — Exit terminal mode.

4. Whitespace
- **`<leader>S`** — Strip trailing whitespaces from the file.

5. Telescope (File Finder)
- **`<leader>ff`** — Find files.
- **`<leader>fg`** — Live grep through project files.
- **`<leader>fb`** — List open buffers.
- **`<leader>fh`** — Browse help tags.

6. File Tree
- **`<leader><Tab>`** — Open or focus the file tree.
- **`<leader><S-Tab>`** — Toggle the file tree visibility.

7. Window Navigation
- **`<C-h>`** — Move to the left window.
- **`<C-j>`** — Move to the window below.
- **`<C-k>`** — Move to the window above.
- **`<C-l>`** — Move to the right window.

8. Window Resizing
- **`<A-j>`** — Increase window height.
- **`<A-k>`** — Decrease window height.
- **`<A-h>`** — Increase window width.
- **`<A-l>`** — Decrease window width.

9. Moving Code Blocks
- **Visual mode `J`** — Move selected chunk down.
- **Visual mode `K`** — Move selected chunk up.

10. Navigation Shortcuts
- **`<leader>h`** — Jump to beginning of line.
- **`<leader>l`** — Jump to end of line.
- **`<leader>k`** — Jump to top of file.
- **`<leader>j`** — Jump to bottom of file.

11. Editing Enhancements
- **Visual `<` / `>`** — Indent left/right while keeping selection.
- **Visual `p`** — Paste over selection without overwriting the yank buffer.
- **`<leader>va`** — Select the entire file (character-wise).


### Installing colorschemes or plugins

To install colorschemes or plugins, navigate to the `lua/plugins` directory. Create a new file with the same name as the colorscheme or plugin you want to add. In this file, copy the installation snippet provided by the developper. For example, for the tokyonight colorscheme, the provided snippet is:

```lua
{
    "folke/tokyonight.nvim",
    	lazy = false,
	priority = 1000,
	opts = {},
}
```

So lazy can detect the pluggin, you need to manually add a `return` before the snippet:

```lua
return {
    "folke/tokyonight.nvim",
    	lazy = false,
	priority = 1000,
	opts = {},
}
```

Some developers do no not provide a lua snippet, in which case you can often default back to this standard installation snippet:

```lua
return {
    "folke/tokyonight.nvim",
	opts = {},
}
```

In the last example, the string `folke/tokyonight.nvim` is the ending segment of the Github repository url: `https://github.com/folke/tokyonight.nvim`. The same is to be done for all plugins - strip the `https://github.com/` segment from the url.

### Managing Plugins
To update, uninstall or generally manage plugins, use the `:Lazy` command in neovim. Then `shift-u` or more simply `U` to update plugins. Use the built-in help menu for more guidance.

## LaTeX

To start the compilation of a `.tex` (LaTeX) document, use `\\l`. If the compilation fails, use `:copen` or `:cclose` to open/close the logs of the compilation.

The default pdf viewer is **Zathura**, which features similar keybinds to neovim. Make sure to install it on your system. For Ubuntu distros: 
```bash
sudo apt install zathura
```

If you wish to use another pdf viewer, you can change it in `lua/plugins/vimtex.lua`.

