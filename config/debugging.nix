{
  plugins = {
    dap = {
      enable = true;
      configurations.cpp = [
        {
          name = "Launch file";
          type = "cppdbg";
          request = "launch";
          program.__raw = ''function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end'';
          cwd = "\${workspaceFolder}";
          stopAtEntry = false;
          setupCommands = [{
            text = "-enable-pretty-printing";
            description = "enable pretty printing";
            ignoreFailures = false;
          }];
          miMode = "gdb";
          miDebuggerPath = "gdb";
        }
      ];
    };
    dap-ui.enable = true;
  };

  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = os.getenv("OPEN_DEBUG_AD7"),
    }
    dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  '';
}
