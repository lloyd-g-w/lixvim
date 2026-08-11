{lib, ...}: {
  # Import all your configuration modules here
  imports = [
    ./colorschemes.nix
    ./completion.nix
    ./debugging.nix
    ./editing.nix
    ./extras.nix
    ./lsp.nix
    ./file-browsing.nix
    ./languages.nix
    ./mini.nix
    ./ui.nix
    ./which-key.nix
  ];

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
      "presence.nvim"
    ];

  opts = {
    encoding = "utf8";

    expandtab = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;

    number = true;
    relativenumber = true;

    termguicolors = true;

    undodir = "~/.vim/undodir";
    undofile = true;

    cursorline = true;
    hlsearch = false;

    # Allows .nvim.lua files to be loaded
    exrc = true;
    secure = true;
  };

  keymaps = [
    # Clearing annoying keybinds
    {
      mode = "n";
      key = "<S-j>";
      action = "<Nop>";
    }

    # Ctrl-q to exit terminal mode
    {
      mode = "t";
      key = "<C-q>";
      action = "<C-\\><C-n>";
      options = {
        noremap = true;
        silent = true;
        desc = "exit terminal mode";
      };
    }

    # Leader cf to format with conform
    {
      mode = "n";
      key = "<leader>cf";
      action = ":Format<CR>";
      options = {
        silent = true;
        desc = "format";
      };
    }

    # ERRORS
    {
      mode = "n";
      key = "<leader>co";
      action = ":copen<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "open current error list";
      };
    }

    {
      mode = "n";
      key = "<leader>cc";
      action = ":cclose<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "close current error list";
      };
    }

    {
      mode = "n";
      key = "<leader>cn";
      action = ":cnext<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "next error";
      };
    }

    {
      mode = "n";
      key = "<leader>cp";
      action = ":cprev<CR>";
      options = {
        noremap = true;
        silent = true;
        desc = "previous error";
      };
    }

    # DIAGNOSTICS
    {
      mode = "n";
      key = "<leader>do";
      action.__raw = "vim.diagnostic.open_float";
      options = {
        noremap = true;
        silent = true;
        desc = "open hovering diagnostic";
      };
    }

    {
      mode = "n";
      key = "<leader>dn";
      action.__raw = "vim.diagnostic.goto_next";
      options = {
        noremap = true;
        silent = true;
        desc = "next error";
      };
    }

    {
      mode = "n";
      key = "<leader>dp";
      action.__raw = "vim.diagnostic.goto_prev";
      options = {
        noremap = true;
        silent = true;
        desc = "previous error";
      };
    }
  ];
}
