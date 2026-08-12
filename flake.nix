{
  description = "Lixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs: let
  lixvim-deps = pkgs: with pkgs;[
# For image.nvim plugin
        luajitPackages.magick
        imagemagick
        luarocks
        lua5_1

        lazygit
        tree-sitter
        texpresso
        tectonic
        ripgrep

        nixd
        texlab
        lua-language-server
        svelte-language-server
        jdt-language-server
        typescript-language-server
        vim-language-server
        basedpyright
        csharp-ls
        cmake-language-server
        tailwindcss-language-server
        tinymist
        rust-analyzer
        zls
        qt6Packages.qtdeclarative

        # C++
        # Clangd from clang-tools must come first.
        # (lib.hiPrio clang-tools)

        # Do not use the clangd from this package as it does not work correctly with
        # stdlib headers.
        # clang

        tex-fmt
        rustfmt
        markdownlint-cli
        alejandra
        yq-go
        black
        jq
        stylua
        astyle

        vscode-extensions.ms-vscode.cpptools
        gdb
  ];

  in

    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = {system,pkgs, ...}: let
        configuration = nixvim.lib.evalNixvim {
          inherit system;

          modules = [./config
          {extraPackages = lixvim-deps pkgs;
          }

          ];

          extraSpecialArgs = {};
        };
      in {
        checks.default = configuration.config.build.test;
        packages.default = configuration.config.build.package;

        legacyPackages.nixvimOptions = configuration.options;
      };
    };
}
