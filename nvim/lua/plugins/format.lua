return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },
          html = { "prettierd" },
          css = { "prettierd" },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          markdown = { "prettierd" },
          yaml = { "prettierd" },
          lua = { "stylua" },
        },
        format_on_save = function(bufnr)
          local filetype = vim.bo[bufnr].filetype
          local supported = {
            javascript = true,
            javascriptreact = true,
            typescript = true,
            typescriptreact = true,
            html = true,
            css = true,
            json = true,
            jsonc = true,
            markdown = true,
            yaml = true,
            lua = true,
          }

          if supported[filetype] then
            return {
              lsp_fallback = true,
              timeout_ms = 2000,
            }
          end

          return nil
        end,
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettierd",
          "eslint_d",
          "stylua",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
      })
    end,
  },
}
