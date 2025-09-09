-- ============================================================================
-- PLUGINS CONFIGURATION
-- ============================================================================
-- This file contains all Neovim plugin specifications
-- Organized by category for better maintainability

return {
  -- ============================================================================
  -- CORE DEPENDENCIES
  -- ============================================================================
  { lazy = true, "nvim-lua/plenary.nvim" }, -- Lua functions library

  -- ============================================================================
  -- FORMATTING & LINTING
  -- ============================================================================
  {
    "stevearc/conform.nvim",
    opts = require("plugins.configs.conform"),
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.lint")
    end,
  },

  -- ============================================================================
  -- LSP & COMPLETION
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "windwp/nvim-autopairs", opts = {} }, -- Auto-pairs for completion
    },
    opts = function()
      return require("plugins.configs.blink")
    end,
  },

  -- ============================================================================
  -- SYNTAX & PARSING
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
  },

  -- ============================================================================
  -- AI & CODING ASSISTANCE
  -- ============================================================================
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_filetypes = {
        ["*"] = true,
        markdown = false,
        gitcommit = false,
      }
    end,
  },

  -- ============================================================================
  -- PACKAGE MANAGEMENT
  -- ============================================================================
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  -- ============================================================================
  -- UI & VISUAL ENHANCEMENTS
  -- ============================================================================
  {
    "iagorrr/noctis-high-contrast.nvim",
    lazy = false,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = require("plugins.keys.bufferline"),
    config = function()
      require("bufferline").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "                        ,----,                   _.--,-```-.    ",
        "                      ,/   .`|                  /    /      '.  ",
        "           .---.    ,`   .'  :   ,---,.        /  ../         ; ",
        "          /. ./|  ;    ;     / ,'  .' |        \\  ``\\  .``-    '",
        "      .--'.  ' ;.'___,/    ,',---.'   |         \\ ___\\/    \\   :",
        "     /__./ \\ : ||    :     | |   |   .'               \\    :   |",
        " .--'.  '   \\' .;    |.';  ; :   :  :                 |    ;  . ",
        "/___/ \\ |    ' '`----'  |  | :   |  |-,              ;   ;   :  ",
        ";   \\  \\;      :    '   :  ; |   :  ;/|             /   :   :   ",
        " \\   ;  `      |    |   |  ' |   |   .'             `---'.  |   ",
        "  .   \\    .\\  ;    '   :  | '   :  '                `--..`;    ",
        "   \\   \\   ' \\ |    ;   |.'  |   |  |              .--,_        ",
        "    :   '  |--'     '---'    |   :  \\              |    |`.     ",
        "     \\   \\ ;                 |   | ,'              `-- -`, ;    ",
        "      '---'                  `----'                  '---`'     ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find Files", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  LazyGit", ":LazyGit<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      alpha.setup(dashboard.opts)
    end,
  },

  -- ============================================================================
  -- NAVIGATION & SEARCH
  -- ============================================================================
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = require("plugins.keys.telescope"),
    opts = require("plugins.configs.telescope"),
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    keys = require("plugins.keys.flash"),
  },

  -- ============================================================================
  -- FILE MANAGEMENT
  -- ============================================================================
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open yazi at current working directory",
      },
    },
    opts = require("plugins.configs.yazi"),
  },

  -- ============================================================================
  -- GIT INTEGRATION
  -- ============================================================================
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last")
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first")
        end, "First Hunk")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>gB", function()
          gs.blame()
        end, "Blame Buffer")
        -- map("n", "<leader>gd", gs.diffthis, "Diff This")
        -- map("n", "<leader>gD", function()
        --   gs.diffthis("~")
        -- end, "Diff This ~")
      end,
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
      { "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", desc = "Focus Files Panel" },
      { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Files Panel" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      { "<leader>gs", "<cmd>DiffviewOpen --staged<cr>", desc = "Staged Changes" },
      { "<leader>gr", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Compare with HEAD~1" },
      { "<leader>gm", "<cmd>DiffviewOpen main<cr>", desc = "Compare with main" },
    },
    config = function()
      require("diffview").setup({
        view = {
          default = {
            layout = "diff2_horizontal",
          },
        },
      })

      -- Subtle, theme-appropriate colors (no screaming red)
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1a2a1a", fg = "#98c379" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2a2520", fg = "#e5c07b" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#2a1a1a", fg = "#e06c75" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#3a2a1a", fg = "#e5c07b" })

      -- Diffview-specific highlights
      vim.api.nvim_set_hl(0, "DiffviewNormal", { bg = "#0f0f0f" })
      vim.api.nvim_set_hl(0, "DiffviewWinSeparator", { fg = "#2a2a35", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiffviewCursorLine", { bg = "#1a1a1a" })
      vim.api.nvim_set_hl(0, "DiffviewFilePanelTitle", { fg = "#61dafb", bold = true })
      vim.api.nvim_set_hl(0, "DiffviewFilePanelCounter", { fg = "#e5c07b", bold = true })

      -- Ensure highlights persist on theme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1a2a1a", fg = "#98c379" })
          vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2a2520", fg = "#e5c07b" })
          vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#2a1a1a", fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "DiffText", { bg = "#3a2a1a", fg = "#e5c07b" })
          vim.api.nvim_set_hl(0, "DiffviewNormal", { bg = "#0f0f0f" })
          vim.api.nvim_set_hl(0, "DiffviewWinSeparator", { fg = "#2a2a35", bg = "NONE" })
          vim.api.nvim_set_hl(0, "DiffviewCursorLine", { bg = "#1a1a1a" })
          vim.api.nvim_set_hl(0, "DiffviewFilePanelTitle", { fg = "#61dafb", bold = true })
          vim.api.nvim_set_hl(0, "DiffviewFilePanelCounter", { fg = "#e5c07b", bold = true })
        end,
      })
    end,
  },

  -- ============================================================================
  -- UTILITIES & ENHANCEMENTS
  -- ============================================================================
  {
    "nvimdev/indentmini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function()
      require("indentmini").setup()
      vim.api.nvim_set_hl(0, "IndentLine", { fg = "#2e2e38" })
      vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = "#4a4a55" })
      vim.api.nvim_set_hl(0, "IndentLineContext", { fg = "#3a3a45" })

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "IndentLine", { fg = "#2e2e38" })
          vim.api.nvim_set_hl(0, "IndentLineCurrent", { fg = "#4a4a55" })
          vim.api.nvim_set_hl(0, "IndentLineContext", { fg = "#3a3a45" })
        end,
      })
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "athar-qadri/scratchpad.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>.", "<cmd>Scratch<cr>", desc = "Open Scratchpad" },
    },
    config = function()
      require("scratchpad"):setup()
    end,
  },

  -- ============================================================================
  -- DIAGNOSTICS & TROUBLESHOOTING
  -- ============================================================================
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>cs",
        false,
        desc = "Symbols (Trouble)",
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    keys = { { "<leader>cs", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
    cmd = "Outline",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    keys = require("plugins.keys.todo-comments"),
    opts = require("plugins.configs.todo-comments"),
  },

  -- ============================================================================
  -- HELPER PLUGINS
  -- ============================================================================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  -- ============================================================================
  -- TERMINAL MANAGEMENT
  -- ============================================================================
  {
    "akinsho/toggleterm.nvim",
    config = function(_, opts)
      require("toggleterm").setup(opts)
      local Terminal = require("toggleterm.terminal").Terminal

      -- Generic terminals
      local bottom_term = Terminal:new({ direction = "horizontal" })
      local right_term = Terminal:new({ direction = "vertical" })

      -- Language-specific terminals
      local bottom_python = Terminal:new({ cmd = "python", direction = "horizontal" })
      local right_python = Terminal:new({ cmd = "python", direction = "vertical" })
      local bottom_node = Terminal:new({ cmd = "node", direction = "horizontal" })
      local right_node = Terminal:new({ cmd = "node", direction = "vertical" })

      -- Claude floating terminal
      local claude_term = Terminal:new({
        cmd = "claude",
        direction = "float",
        hidden = true,
        float_opts = {
          border = "curved",
        },
      })
      local gemine_term = Terminal:new({
        cmd = "gemini",
        direction = "float",
        hidden = true,
        float_opts = {
          border = "curved",
        },
      })

      -- Toggle functions
      function _toggle_bottom()
        bottom_term:toggle()
      end

      function _toggle_right()
        right_term:toggle()
      end

      function _toggle_bottom_python()
        bottom_python:toggle()
      end

      function _toggle_right_python()
        right_python:toggle()
      end

      function _toggle_bottom_node()
        bottom_node:toggle()
      end

      function _toggle_right_node()
        right_node:toggle()
      end

      function _toggle_claude()
        claude_term:toggle()
      end

      function _toggle_gemine()
        gemine_term:toggle()
      end

      -- Keymaps
      vim.keymap.set("n", "<leader>H", _toggle_bottom, { desc = "ToggleTerm bottom" })
      vim.keymap.set("n", "<leader>L", _toggle_right, { desc = "ToggleTerm right" })
      vim.keymap.set("n", "<leader>hP", _toggle_bottom_python, { desc = "Python bottom" })
      vim.keymap.set("n", "<leader>lP", _toggle_right_python, { desc = "Python right" })
      vim.keymap.set("n", "<leader>hN", _toggle_bottom_node, { desc = "Node bottom" })
      vim.keymap.set("n", "<leader>lN", _toggle_right_node, { desc = "Node right" })
      vim.keymap.set("n", "<leader>hC", _toggle_claude, { desc = "Claude (float)" })
      vim.keymap.set("n", "<leader>hG", _toggle_gemine, { desc = "Gemine (float)" })

      vim.api.nvim_set_keymap("t", "<C-x>", "<C-\\><C-n><C-w>w", { noremap = true, silent = true })
    end,
    opts = {
      open_mapping = false,
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },

  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
}
