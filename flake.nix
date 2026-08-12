{
  description = "Lixvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{
    nixvim,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      flake.homeManagerModules.default = {
        config,
        lib,
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
          };
        };
      };

      perSystem = { system, ... }: let
        configuration = nixvim.lib.evalNixvim {
          inherit system;

          modules = [
            ./config
          ];
        };
      in {
        packages = {
          lixvim = configuration.config.build.package;
          default = configuration.config.build.package;
        };

        checks.default = configuration.config.build.test;
      };
    };
}
