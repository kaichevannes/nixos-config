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
      mkHost =
        hostname: user: aspects:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs user; };

          modules = [
            ./hosts/${hostname}/hardware-configuration.nix
            ./users/${user}.nix
            ./aspects/_base
            { networking.hostName = hostname; }
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
        mkHost hostname spec.user spec.aspects
      ) (builtins.readDir ./hosts);
    };
}
