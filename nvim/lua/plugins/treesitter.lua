return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    config = function()
      local parser_install_dir = vim.fn.stdpath("data") .. "/site"
      vim.opt.runtimepath:prepend(parser_install_dir)

      require('nvim-treesitter.configs').setup {
        parser_install_dir = parser_install_dir,
        ensure_installed = {
          "c", "lua", "vim", "python", "make", "rust", "go", "cpp", "bash", "json", "yaml", "markdown", "dockerfile"
        },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = false,
          additional_vim_regex_highlighting = false,
        },

        indent = { enable = true },

        refactor = {
          highlight_definitions = { enable = false },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = true,
            keymaps = {
            },
          },
        },
      }
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      local api = require("Comment.api")

      require('Comment').setup()

      -- Toggle comment
      vim.keymap.set("n", "<leader>c", api.toggle.linewise.current, { desc = "Toggle comment line" })
      vim.keymap.set("v", "<leader>c", function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end, { desc = "Toggle comment selection" })

      -- Uncomment explicitly
      vim.keymap.set("n", "<leader>cc", api.uncomment.linewise.current, { desc = "Uncomment line" })
      vim.keymap.set("v", "<leader>cc", function()
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.uncomment.linewise(vim.fn.visualmode())
      end, { desc = "Uncomment selection" })
    end,
  },
}
