return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Debug: conditional breakpoint",
      },
      { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "Debug: log point" },

      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: start/continue" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Debug: restart" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug: stop" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Debug: pause" },

      { "<leader>dn", function() require("dap").step_over() end, desc = "Debug: step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug: step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Debug: step out" },
      { "<leader>dk", function() require("dap").run_to_cursor() end, desc = "Debug: run to cursor" },

      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle UI" },
      { "<leader>de", function() require("dap").repl.open() end, desc = "Debug: open REPL" },
      { "<leader>dh", function() require("dapui").eval() end, desc = "Debug: eval under cursor" },
      { "<leader>dw", function() require("dapui").float_element("watches", { enter = true }) end, desc = "Debug: watches" },
      { "<leader>ds", function() require("dapui").float_element("scopes", { enter = true }) end, desc = "Debug: scopes" },
      { "<leader>dt", function() require("dapui").float_element("stacks", { enter = true }) end, desc = "Debug: stacks" },
      { "<leader>df", function() require("dapui").float_element("repl", { enter = true }) end, desc = "Debug: floating REPL" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason").setup()

      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",   -- debugpy
          "delve",    -- Go
          "codelldb", -- Rust / C / C++ / Zig
        },
        handlers = {},
      })

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "DiagnosticInfo" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- dap.configurations.python = {
      --   {
      --     type = "python",
      --     request = "launch",
      --     name = "Launch current file",
      --     program = "${file}",
      --     console = "integratedTerminal",
      --   },
      -- }
    end,
  },
}
