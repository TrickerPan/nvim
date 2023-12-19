return {
  {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "mfussenegger/nvim-jdtls",
    },
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
