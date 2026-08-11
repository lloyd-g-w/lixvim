{config, pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.grapple-nvim];

  plugins = {
    conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        lua = ["stylua"];
        python = ["black"];
        rust = ["rustfmt"];
        javascript = ["prettier"];
        typescript = ["prettier"];
        yaml = ["yq"];
        json = ["jq"];
        jsonc = ["prettier"];
        nix = ["alejandra"];
        tex = ["tex-fmt"];
        css = ["prettier"];
        markdown = ["markdownlint"];
        cpp = ["clang-format"];
        c = ["clang-format" "astyle"];
        ocaml = ["ocamlformat"];
      };
    };

    treesitter = {
      enable = true;
      grammarPackages = with config.plugins.treesitter.package.parsers; [
        c lua vim vimdoc query svelte typescript javascript
      ];
      highlight.enable = true;
      indent.enable = true;
    };

    colorizer = {
      enable = true;
      settings.filetypes = {
        "*" = {};
        css = {rgb_fn = true; oklch_fn = true;};
      };
    };
    guess-indent.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope = {enabled = true; show_start = false; show_end = false;};
      };
    };
    todo-comments.enable = true;

    flash = {
      enable = true;
      settings = {};
    };
    gitsigns.enable = true;
    lazygit.enable = true;
    tmux-navigator.enable = true;
  };

  keymaps = [
    {mode = ["n" "x" "o"]; key = "s"; action.__raw = "function() require('flash').jump() end"; options.desc = "Flash";}
    {mode = ["n" "x" "o"]; key = "S"; action.__raw = "function() require('flash').treesitter() end"; options.desc = "Flash Treesitter";}
    {mode = "n"; key = "<leader>g"; action = "<cmd>LazyGit<CR>"; options.desc = "LazyGit";}
    {mode = "n"; key = "<leader>m"; action.__raw = "function() require('grapple').toggle() end"; options.desc = "Grapple current file";}
    {mode = "n"; key = "<leader>M"; action.__raw = "function() require('grapple').toggle_tags() end"; options.desc = "Grapple tags";}
    {mode = "n"; key = "<C-h>"; action = "<cmd>TmuxNavigateLeft<CR>"; options.silent = true;}
    {mode = "n"; key = "<C-j>"; action = "<cmd>TmuxNavigateDown<CR>"; options.silent = true;}
    {mode = "n"; key = "<C-k>"; action = "<cmd>TmuxNavigateUp<CR>"; options.silent = true;}
    {mode = "n"; key = "<C-l>"; action = "<cmd>TmuxNavigateRight<CR>"; options.silent = true;}
  ];

  extraConfigLua = ''
    for index = 1, 6 do
      vim.keymap.set("n", "<leader>" .. index, function()
        require("grapple").select({ index = index })
      end, { desc = "Grapple select " .. index })
    end

    vim.api.nvim_create_user_command("Format", function(args)
      local range
      if args.count ~= -1 then
        local last = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ["end"] = { args.line2, #last } }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
  '';
}
