{
  plugins = {
    which-key = {
      enable = true;

      settings.spec = [
        {
          __unkeyed-1 = "<leader>f";
          group = "file";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "code";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "diagnostics";
        }
      ];
    };
  };
}
