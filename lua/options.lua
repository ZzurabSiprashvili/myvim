-- ============================================================================
-- NEOVIM OPTIONS CONFIGURATION
-- ============================================================================
-- This file contains all Neovim editor options and settings
-- Organized by category for better maintainability

local o = vim.o

-- ============================================================================
-- LEADER KEY
-- ============================================================================
vim.g.mapleader = " "                    -- Set leader key to space

-- ============================================================================
-- EDITOR BEHAVIOR
-- ============================================================================
o.laststatus = 3                        -- Global statusline
o.showmode = false                      -- Hide mode (shown in statusline)
o.clipboard = "unnamedplus"             -- Use system clipboard
o.mouse = "a"                          -- Enable mouse support
o.timeoutlen = 400                     -- Timeout for mapped sequences
o.undofile = true                      -- Persistent undo

-- ============================================================================
-- INDENTATION & FORMATTING
-- ============================================================================
o.expandtab = true                      -- Use spaces instead of tabs
o.shiftwidth = 2                        -- Indent size
o.smartindent = true                    -- Smart indentation
o.tabstop = 2                          -- Tab width
o.softtabstop = 2                      -- Soft tab width

-- ============================================================================
-- SEARCH & NAVIGATION
-- ============================================================================
o.ignorecase = true                     -- Case-insensitive search
o.smartcase = true                      -- Case-sensitive if uppercase used
o.cursorline = true                     -- Highlight current line

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================
o.splitbelow = true                     -- Horizontal splits below
o.splitright = true                     -- Vertical splits right
o.signcolumn = "yes"                    -- Always show sign column

-- ============================================================================
-- VISUAL & UI
-- ============================================================================
o.number = true                         -- Show line numbers
o.relativenumber = true                 -- Relative line numbers
o.termguicolors = true                  -- True color support
vim.opt.fillchars = { eob = " " }       -- Hide end-of-buffer tildes

-- ============================================================================
-- PROVIDER CONFIGURATION
-- ============================================================================
-- Mason binary path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-- Python provider configuration
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- Suppress optional provider warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- ============================================================================
-- UI CUSTOMIZATION
-- ============================================================================
-- Indent line highlighting
vim.api.nvim_set_hl(0, "IndentLine", { link = "Comment" })

-- Completion menu colors (Noctis theme)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#ff669c", bg = "#1a1a1a" })
  end,
})

-- ============================================================================
-- END OF OPTIONS
-- ============================================================================

-- Also set it immediately in case colorscheme is already loaded
vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#ff669c", bg = "#1a1a1a" })

