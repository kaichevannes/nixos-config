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
      nixosConfigurations = {
        camus =
          let
            hostname = "camus";
            user = "cheva";
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs hostname user; };

            modules = [
              ./hosts/camus/hardware-configuration.nix

              ./users/cheva.nix

              ./aspects/base
              ./aspects/nixos
              ./aspects/nvidia
              ./aspects/dev
              ./aspects/desktop
              ./aspects/art
              ./aspects/virtualisation

              sops-nix.nixosModules.default
            ];
          };

        # sartre = mkHost {
        #   hostname = "sartre";
        #   aspects = [
        #     "wsl"
        #     "dev"
        #   ];
        #   user = "cheva";
        # };
      };
    };
}
