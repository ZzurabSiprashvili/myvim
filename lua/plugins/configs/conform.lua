return {
  formatters_by_ft = {

    -- Lua
    lua = { "stylua" },

    -- JavaScript / TypeScript / HTML / CSS / JSON
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },

    -- Python
    python = { "ruff_format", "ruff_organize_imports" },

    -- Go
    go = { "gofumpt" },

    -- Terraform
    terraform = { "terraform_fmt" }, -- Use terraform-ls formatter
    hcl = { "terraform_fmt" },

    -- SQL

    -- Swift
    swift = { "swiftformat" , "xcbeautify"},

    -- YAML
    yaml = { "prettier_yaml" },

    -- Shell scripts
    sh = { "shfmt" },
    bash = { "shfmt" },

    -- Markdown
    markdown = { "prettier" },

    -- Prisma
    prisma = { "prisma_fmt" }, -- Use prisma language server formatter

    -- TOML
    toml = { "prettier_toml" },

    -- XML
    xml = { "xmllint" },

    -- Optional: other filetypes you use
    jsonc = { "prettier" },
    scss = { "prettier" },
    sass = { "prettier" },
    tsx = { "prettier" },
    jsx = { "prettier" },
  },

  -- Formatter configurations
  formatters = {
    -- Prisma formatter configuration
    prisma_fmt = {
      command = "prisma",
      args = { "format", "$FILENAME" },
      stdin = false,
    },

    -- Terraform formatter configuration
    terraform_fmt = {
      command = "terraform",
      args = { "fmt", "-" },
      stdin = true,
    },

    -- Use prettier for YAML instead of yamllint (more commonly available)
    prettier_yaml = {
      command = "prettier",
      args = { "--parser", "yaml", "--stdin-filepath", "$FILENAME" },
      stdin = true,
    },

    -- Use prettier for TOML instead of taplo (more commonly available)
    prettier_toml = {
      command = "prettier",
      args = { "--parser", "toml", "--stdin-filepath", "$FILENAME" },
      stdin = true,
    },
  },

  -- -- Global formatting options
  format_on_save = false,
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true, -- Use LSP formatter as fallback
  -- },

  -- Default options for all formatters
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback", -- Use LSP as fallback when formatter fails
  },
}
