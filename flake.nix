{
  description = "Dendritic pattern without dependencies";

  inputs = {
    nixpgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      files = aspect: builtins.attrNames (builtins.readDir ./aspects/${aspect});

      aspectModules = aspect: map (file: (import ./aspects/${aspect}/${file}).homeManager) (files aspect);

      homeModules = aspects: builtins.concatMap aspectModules aspects;
    in
    {
      homeConfigurations = {
        "wsl" =
          let
            aspects = [ "dev" ];
          in
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = homeModules aspects ++ [
              ./hosts/wsl/home.nix
            ];
          };
      };
    };
}
