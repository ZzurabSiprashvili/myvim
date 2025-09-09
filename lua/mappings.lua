-- ============================================================================
-- KEY MAPPINGS CONFIGURATION
-- ============================================================================
-- This file contains all custom key mappings for Neovim
-- Organized by category for better maintainability

local map = vim.keymap.set

-- ============================================================================
-- BASIC EDITOR MAPPINGS
-- ============================================================================

-- Clear search highlighting
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { silent = true })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

-- Split navigation (both Ctrl and Shift variants)
map("n", "H", "<C-w>h", { desc = "Move to left split" })
map("n", "J", "<C-w>j", { desc = "Move to below split" })
map("n", "K", "<C-w>k", { desc = "Move to above split" })
map("n", "L", "<C-w>l", { desc = "Move to right split" })

-- Alternative split navigation (Shift variants)
map("n", "<S-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<S-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<S-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<S-l>", "<C-w>l", { desc = "Move to right split" })

-- Create splits
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Create vertical split" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Create horizontal split" })

-- ============================================================================
-- CODE EDITING
-- ============================================================================

-- Comments (requires comment.nvim)
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- Formatting (requires conform.nvim)
local function format_buffer()
  local conform = require("conform")
  conform.format({
    timeout_ms = 3000,
    lsp_fallback = true,
    async = true,
  }, function(err)
    if err then
      vim.notify("Formatting failed: " .. err, vim.log.levels.ERROR)
    else
      vim.notify("Buffer formatted successfully", vim.log.levels.INFO)
    end
  end)
end

map("n", "++", format_buffer, { desc = "Format current buffer" })
map("v", "++", format_buffer, { desc = "Format selection" })

-- ============================================================================
-- LSP (Language Server Protocol)
-- ============================================================================

-- Code Actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
map("v", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })

-- Navigation
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find references" })
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition" })

-- ============================================================================
-- DIAGNOSTICS & TROUBLESHOOTING
-- ============================================================================

-- Diagnostics (requires trouble.nvim)
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics window" })
map("n", "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  { desc = "Toggle diagnostics for current buffer" })
map("n", "<leader>xr", "<cmd>lua vim.diagnostic.reset()<CR>", { desc = "Reset diagnostics" })

-- ============================================================================
-- END OF MAPPINGS
-- ============================================================================
