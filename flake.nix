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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
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
      helix,
      ...
    }@inputs:
    let
      requires = map (name: ./aspects/_common/${name});

      mkHost =
        hostname: aspects: meta:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs requires; };

          modules = [
            ./aspects/_common/base
            ./hosts/${hostname}/filesystem.nix
            {
              meta = meta // {
                inherit hostname;
              };
            }
          ]
          ++ map (aspect: ./aspects/${aspect}) aspects;
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        # e.g. ["camus" = "directory", "sartre" = "directory"]
        # is   [hostname = _, hostname = _]
        # Replace _ with the nixos system configuration for this host.
        hostname: _:
        let
          spec = import ./hosts/${hostname}/spec.nix;
        in
        mkHost hostname spec.aspects spec.meta
      ) (builtins.readDir ./hosts);

      # Install script for all system (e.g. x86_64-linux, aarch64-linux, ...)
      packages = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          install = import ./install.nix { inherit pkgs; };
        }
      );
    };
}
