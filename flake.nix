{
  description = "Dendritic pattern without flake-parts or import-tree.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      # Dev-only dependencies
      inputs.nixpkgs.follows = "";
      inputs.home-manager.follows = "";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      home-manager,
      sops-nix,
      impermanence,
      helix,
      ...
    }@inputs:
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        hostname: _:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${hostname}
            ./modules
            ./profiles
            { meta.hostname = hostname; }
          ];
        }
      ) (builtins.readDir ./hosts);

      # Install script for all systems (e.g. x86_64-linux, aarch64-linux, ...)
      packages = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        {
          install = import ./install.nix { inherit pkgs; };
        }
      );
    };
}
