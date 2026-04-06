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
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (
        host: _:
        let
          inherit (import ./hosts/${host}/spec.nix) user aspects;
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs user; };

          modules = [
            ./hosts/${host}/hardware-configuration.nix
            ./users/${user}.nix
            { networking.hostName = host; }
          ]
          ++ map (aspect: ./aspects/${aspect}) aspects;
        }
      ) (builtins.readDir ./hosts);
    };
}
