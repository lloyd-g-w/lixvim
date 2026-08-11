{
  plugins = {
    telescope.enable = true;

    oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        delete_to_trash = true;

        columns = [
          "icon"
          "size"
        ];
      };
    };
  };

  keymaps = [
    # Telescope
    {
      mode = "n";
      key = "<leader>ff";
      action.__raw = "require('telescope.builtin').find_files";
      options.desc = "find files";
    }

    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = "require('telescope.builtin').live_grep";
      options.desc = "live grep";
    }

    {
      mode = "n";
      key = "<leader>fb";
      action.__raw = "require('telescope.builtin').buffers";
      options.desc = "buffers";
    }

    {
      mode = "n";
      key = "<leader>fh";
      action.__raw = "require('telescope.builtin').help_tags";
      options.desc = "help tags";
    }

    # Oil
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Oil<CR>";
      options.desc = "file explorer";
    }
  ];
}
