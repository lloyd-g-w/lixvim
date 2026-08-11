{
  plugins = {
    lz-n.enable = true;
    avante = {
      enable = true;
      lazyLoad.settings.event = "VeryLazy";
      settings = {
        provider = "copilot";
        instructions_file = "avante.md";
      };
    };
    copilot-vim = {
      enable = true;
      settings = {
        enabled = false;
        no_tab_map = true;
      };
    };
    leetcode = {
      enable = true;
      settings.image_support = true;
    };
    presence.enable = true;
  };

  keymaps = [{
    mode = "i";
    key = "<C-f>";
    action = ''copilot#Accept("\\<CR>")'';
    options = {expr = true; replace_keycodes = false;};
  }];
}
