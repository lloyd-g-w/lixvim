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

  extraConfigLua = ''
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    vim.api.nvim_set_hl(0, "AlphaHeader", { link = "Keyword" })

    dashboard.section.header.val = {
  [[ ██╗     ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗ ]],
  [[ ██║     ██║╚██╗██╔╝██║   ██║██║████╗ ████║ ]],
  [[ ██║     ██║ ╚███╔╝ ██║   ██║██║██╔████╔██║ ]],
  [[ ██║     ██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
  [[ ███████╗██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
  [[ ╚══════╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
}

    dashboard.section.header.opts.hl = "AlphaHeader"

    dashboard.section.buttons.val = {
      dashboard.button(
        "e",
        "  New file",
        "<cmd>ene <BAR> startinsert<CR>"
      ),
      dashboard.button(
        "f",
        "  Find file",
        "<cmd>Telescope find_files<CR>"
      ),
      dashboard.button(
        "r",
        "  Recent files",
        "<cmd>Telescope oldfiles<CR>"
      ),
      dashboard.button(
        "q",
        "  Quit",
        "<cmd>qa<CR>"
      ),
    }

    alpha.setup(dashboard.opts)
  '';
}
