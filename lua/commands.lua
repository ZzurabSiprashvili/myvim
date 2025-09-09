-- mason, write correct names only
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd "MasonInstall css-lsp html-lsp lua-language-server typescript-language-server stylua prettier"
  vim.cmd "MasonInstall black checkstyle commitlint css-lsp debugpy delve docker-compose-language-service dockerfile-language-server eslint-lsp eslint_d flake8 gofumpt golangci-lint gopls html-lsp htmlhint isort json-lsp jsonlint lua-language-server luacheck markdownlint marksman mesonlsp mypy postgrestools prettier prettierd prettydiff prettypst prisma-language-server proselint pyright ruff shellcheck shfmt sql-formatter sqlfluff sqlls stylelint stylua swiftlint tailwindcss-language-server taplo terraform terraform-ls tflint typescript-language-server xcbeautify yaml-language-server yamllint"
end, {})
