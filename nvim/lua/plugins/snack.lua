return {
    "folke/snacks.nvim",
     priority = 1000,
     lazy = false,
     ---@type snacks.Config
     opts = {
       bigfile = { enabled = true },
       dashboard = { enabled = false },
       indent = { enabled = false },
       input = { enabled = true },
       notifier = { enabled = true },
       -- quickfile = { enabled = true },
       scroll = { enabled = false },
       statuscolumn = { enabled = true },
       words = { enabled = true },
     },
     keys = {
       { "<C-j>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
       { "<C-k>", function() Snacks.terminal():close() end, desc = "Quit Terminal", mode = {"n", "t"} },
     },
     config = function(_, opts)
         require("snacks").setup(opts)
         vim.ui.input = require("snacks.input").input
         vim.ui.select = require("snacks.picker").select
     end,
}
