{
  plugins.lsp = {
    enable = true;

    servers = {
      hls = {enable = true; installGhc = false;};
      clangd = {
        enable = true;
        cmd = [
          "clangd"
          "--background-index"
          "--clang-tidy"
          "--header-insertion=never"
          "--query-driver=/nix/store/*/bin/clang*,/nix/store/*/bin/g++,/nix/store/*/bin/gcc,/run/current-system/sw/bin/clang*,/run/current-system/sw/bin/g++,/run/current-system/sw/bin/gcc"
        ];
      };
      nixd = {
        enable = true;
        settings.nixd.options.nixvim.expr = "(builtins.getFlake (toString ./.)).legacyPackages.\${builtins.currentSystem}.nixvimOptions";
      };
      rust_analyzer = {enable = true; installCargo = false; installRustc = false;};
      ocamllsp.enable = true;
      svelte.enable = true;
      tinymist = {
        enable = true;
        settings = {formatterMode = "typstyle"; formatterPrintWidth = 80; formatterIndentSize = 2; formatterProseWrap = true;};
      };
      csharp_ls.enable = true;
      ts_ls.enable = true;
      basedpyright.enable = true;
      vimls.enable = true;
      lua_ls.enable = true;
      cmake.enable = true;
      zls.enable = true;
      texlab.enable = true;
      qmlls.enable = true;
    };
  };

  diagnostic.settings = {
    virtual_text = true;
    signs = true;
    underline = true;
    update_in_insert = false;
    severity_sort = true;
  };

  keymaps = [
    {mode = "n"; key = "gd"; action.__raw = "vim.lsp.buf.definition"; options.desc = "LSP definition";}
    {mode = "n"; key = "K"; action.__raw = "vim.lsp.buf.hover"; options.desc = "LSP hover";}
    {mode = ["n" "v"]; key = "<leader>ca"; action.__raw = "vim.lsp.buf.code_action"; options.desc = "LSP code action";}
  ];
}
