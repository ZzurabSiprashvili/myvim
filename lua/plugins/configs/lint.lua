local lint = require("lint")

-- Configure linters for different filetypes
lint.linters_by_ft = {
  -- Lua
  lua = { "luacheck" },

  -- JavaScript/TypeScript
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },

  -- Python
  python = { "ruff" },

  -- Go
  go = { "golangcilint" },

  -- Swift
  swift = { "swiftlint" },

  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "shellcheck" },

  -- YAML
  yaml = { "yamllint" },

  -- JSON
  json = { "jsonlint" },

  -- Markdown
  markdown = { "markdownlint" },

  -- Terraform
  terraform = { "tflint" },
  hcl = { "tflint" },

  -- CSS/SCSS
  css = { "stylelint" },
  scss = { "stylelint" },
  sass = { "stylelint" },

  -- HTML
  html = { "htmlhint" },

  -- TOML
  toml = { "taplo" },

  -- Docker
  dockerfile = { "hadolint" },

  -- Git commit messages
  gitcommit = { "commitlint" },
}

-- Set up autocmd to trigger linting
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- Add keybinding to manually trigger linting
vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
