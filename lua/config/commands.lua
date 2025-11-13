
local Commands = {}

function Commands.RunPython()
  local term_buf = nil
  local term_win = nil

  -- Look for an existing terminal window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      term_buf = buf
      term_win = win
      break
    end
  end

  -- If a terminal exists, close and reuse it
  if term_buf and term_win then
    vim.api.nvim_set_current_win(term_win)
    vim.cmd("bdelete! " .. term_buf)
    vim.cmd("vsplit")
  else
    vim.cmd("vsplit")
  end

  -- Run current Python file in new terminal
  vim.cmd("terminal python3 -u " .. vim.fn.expand("%"))

  -- Return to the code window
  vim.cmd.wincmd("p")
end

function Commands.ClosePython()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_set_current_win(win)
      vim.cmd("bdelete! " .. buf)
      --vim.cmd("close")
      return
    end
  end
  vim.notify("No terminal window to close", vim.log.levels.INFO)
end

function Commands.OpenTerminal()

  -- 1. If terminal window exists and is valid, jump to it
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_set_current_win(term_win)
    vim.cmd('startinsert')  -- enter insert mode automatically
    return
  end

  -- 2. Otherwise, create a new terminal
  vim.cmd('belowright split | terminal')
  vim.cmd('resize 15')
  term_buf = vim.api.nvim_get_current_buf()
  term_win = vim.api.nvim_get_current_win()
  vim.cmd('startinsert')
end

function Commands.CloseTerminal()
  -- Check if the window and buffer are valid
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    -- Optionally, check if the buffer is still a terminal
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.api.nvim_buf_delete(term_buf, { force = true })  -- kills terminal buffer
    end

    -- Close the window if it’s still open
    if vim.api.nvim_win_is_valid(term_win) then
      vim.api.nvim_win_close(term_win, true)
    end
  else
    print("No active terminal window to kill.")
  end

  -- Clear references
  term_buf = nil
  term_win = nil
end

function Commands.FocusOrOpenTree()
  local api = require("nvim-tree.api")

  -- Check if NvimTree window is already open
  if api.tree.is_visible() then
    api.tree.focus()
  else
    api.tree.open()
  end
end

-- Searches in the parent directories for a makefile and compile it
function Commands.MakeFile(max_depth)
    max_depth = max_depth or 5 -- default to 5 if not provided

    local function find_makefile(dir, depth)
        depth = depth or 0
        if depth > max_depth then
            return nil
        end

        -- Check for both Makefile and makefile
        local files_to_check = { "Makefile", "makefile" }
        for _, f in ipairs(files_to_check) do
            if vim.fn.filereadable(dir .. '/' .. f) == 1 then
                return dir
            end
        end

        -- Go up one directory
        local parent = vim.fn.fnamemodify(dir, ":h")
        if parent == dir then
            -- Reached root
            return nil
        end

        return find_makefile(parent, depth + 1)
    end

    local start_dir = vim.fn.expand('%:p:h')
    local make_dir = find_makefile(start_dir, 0)

    if make_dir then
        -- Open terminal split and run make
        vim.cmd('belowright split')
        local term_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_set_current_buf(term_buf)

        local term_chan = vim.fn.termopen('make -C ' .. make_dir, {
            on_exit = function(_, exit_code, _)
                if exit_code == 0 then
                    -- Wait 5 seconds, then close the terminal window
                    vim.defer_fn(function()
                        -- Only close if the buffer/window is still valid
                        if vim.api.nvim_buf_is_valid(term_buf) then
                            vim.api.nvim_buf_delete(term_buf, { force = true })
                        end
                    end, 5000)
                else
                    vim.notify("Make failed! Terminal will stay open.", vim.log.levels.ERROR)
                end
            end
        })

        -- Enter terminal mode immediately
        vim.cmd('resize 5')
        vim.cmd('startinsert')
    else
        vim.notify("No Makefile found in current or parent directories (max " ..max_depth..")", vim.log.levels.WARN)
    end
end


return Commands

