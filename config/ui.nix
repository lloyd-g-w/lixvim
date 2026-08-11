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
    notify = {
      enable = true;
      settings = {
        stages = "fade_in_slide_out";
        timeout = 3000;
        background_colour = "#1e222a";
        icons = {error = ""; warn = ""; info = ""; debug = ""; trace = "✎";};
      };
    };
  };
}
