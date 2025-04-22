{
  description = "NixOS configuration for NIX";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        # devShell or other per-system outputs (optional)
      }
    ) // {
      nixosConfigurations.hyprland-box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/hyprland-box/configuration.nix
          ./hosts/hyprland-box/hardware-configuration.nix
        ];
      };
    };
}
