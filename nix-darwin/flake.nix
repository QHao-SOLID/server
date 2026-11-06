# Reference: https://github.com/swaphb/nix-darwin-config

{
  description = "Nix-Darwin Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    hermes-agent.url = "github:NousResearch/hermes-agent";
  };

  outputs = inputs@{ self, nix-homebrew, home-manager, ... }:
    let
      baseDarwin = { config, pkgs, ... }:
        {
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.stateVersion = 5;

          nix = {
            package = pkgs.lix;
            settings = {
              experimental-features = [ "nix-command" "flakes" ];
              auto-optimise-store = true;
              substituters = [
                "https://cache.nixos.org"
                "https://cache.forall.systems/"
              ];
            };
            gc = {
              automatic = true;
              dates = "daily";
              options = "--delete-older-than 7d";
            };
          };

          nixpkgs.config.allowUnfree = true;
        };
    in
    {
      darwinConfigurations."kuruzyy" = nix-darwin.lib.darwinSystem {
        modules = [
          ({ pkgs, ... }: {
            _module.args = {
              username = "kuruzyy";
            };
          })

          baseDarwin
          
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "kuruzyy";
              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
                "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
              };
              autoMigrate = true;
              mutableTaps = true;
            };
          }
          
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;

              users."kuruzyy" = { pkgs, lib, ... }:
              {
                imports = [
                  ./home.nix
                ];
              };
            };
          }
        ];
      };
    };
}
