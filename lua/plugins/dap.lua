local path = require("helpers.path")

return {
  {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      local python = require("helpers.python")

      -- python
      local dap_python = require("dap-python")
      dap_python.setup(path.home .. "/.local/share/virtualenvs/nvim/bin/python")
      -- dap_python.test_runners = "pytest"
      -- dap_python.resolve_python = function()
      --   vim.print(python.path)
      --   return python.path
      -- end

      -- java
      local jdtls = require("jdtls")

      -- configurations
      local dap = require("dap")
      dap.configurations.python = {
        {
          name = "file",
          type = "python",
          request = "launch",
          program = "${file}",
          pythonPath = function()
            return python.path
          end,
        },
        {
          name = "module",
          type = "python",
          request = "launch",
          module = "${file}",
          pythonPath = function()
            return python.path
          end,
        },
        {
          name = "fastapi",
          type = "python",
          request = "launch",
          module = "uvicorn",
          args = { "app.main:app", "--reload" },
          justMyCode = false,
          pythonPath = function()
            return python.path
          end,
        }
      }

      -- widgets
      local widgets = require("dap.ui.widgets")

      -- keymaps
      vim.keymap.set("n", "<F4>", function() dap.terminate() end)
      vim.keymap.set("n", "<F5>", function() dap.continue() end)
      vim.keymap.set("n", "<F10>", function() dap.step_over() end)
      vim.keymap.set("n", "<F11>", function() dap.step_into() end)
      vim.keymap.set("n", "<F12>", function() dap.step_out() end)
      vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
      vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint() end)
      vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
      vim.keymap.set("n", "<leader>dr", function() dap.repl.toggle() end)
      vim.keymap.set("n", "<leader>dl", function() dap.run_last() end)
      vim.keymap.set({ "n", "v" }, "<leader>dh", function()
        widgets.hover()
      end)
      vim.keymap.set({ "n", "v" }, "<leader>dp", function()
        widgets.preview()
      end)
      vim.keymap.set("n", "<leader>df", function()
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set("n", "<leader>dv", function()
        widgets.centered_float(widgets.scopes)
      end)
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    version = "*",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,

        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,

        virt_text_pos = vim.fn.has "nvim-0.10" == 1 and "inline" or "eol",

        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    version = "*",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  }
}
