{
  plugins = {
    alpha = {
      enable = true;
      theme = "dashboard";
    };
    barbecue.enable = true;
    lualine = {
      enable = true;
      settings.options = {
        theme = "onedark";
        section_separators = "";
        component_separators = "";
      };
    };
    noice = {
    enable = true;
    settings = {
        presets = {
      bottom_search = false;
      command_palette = true;
      long_message_to_split = false;
      inc_rename = false;
      };
    };
    };
  };
}
