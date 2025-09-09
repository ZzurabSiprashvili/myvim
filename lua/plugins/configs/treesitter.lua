require("nvim-treesitter.configs").setup {
  ensure_installed = {
    -- Web
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "jsonc",
    "yaml",

    -- Lua
    "lua",
    "vim",
    "vimdoc",

    -- Go
    "go",
    "gomod",

    -- Python
    "python",

    -- Docker
    "dockerfile",

    -- SQL
    "sql",

    -- Terraform
    "terraform",
    "hcl",

    -- Prisma
    "prisma",

    -- Markdown
    "markdown",
    "markdown_inline",},

  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
}
