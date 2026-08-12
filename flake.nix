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
    lixvim-deps = pkgs:
      with pkgs; [
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

        # vscode-extensions.ms-vscode.cpptools
        gdb
      ];

    lixvimModule = {
      config,
      lib,
      pkgs,
      ...
    }: {
      imports = [
        nixvim.homeModules.nixvim
      ];

      options.programs.lixvim.enable =
        lib.mkEnableOption "Lixvim";

      config = lib.mkIf config.programs.lixvim.enable {
        programs.nixvim = {
          enable = true;

          imports = [
            ./config
          ];

          extraPackages = lixvim-deps pkgs;
        };
      };
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      flake.homeManagerModules = {
        lixvim = lixvimModule;
        default = lixvimModule;
      };

      perSystem = {
        system,
        pkgs,
        ...
      }: let
        configuration = nixvim.lib.evalNixvim {
          inherit system;

          modules = [
            ./config
            {
              extraPackages = lixvim-deps pkgs;
            }
          ];
        };
      in {
        checks.default = configuration.config.build.test;

        packages = {
          lixvim = configuration.config.build.package;
          default = configuration.config.build.package;
        };

        legacyPackages.nixvimOptions = configuration.options;
      };
    };
}
