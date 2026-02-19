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
      collectModulesOfKind =
        kind: aspect:
        let
          modules = map (file: import ./aspects/${aspect}/${file}) (
            (builtins.attrNames (builtins.readDir ./aspects/${aspect}))
          );
        in
        map (module: module.${kind}) (builtins.filter (module: builtins.hasAttr kind module) modules);

      homeModules = aspects: builtins.concatMap (collectModulesOfKind "homeManager") aspects;
      nixosModules = aspects: builtins.concatMap (collectModulesOfKind "nixos") aspects;
    in
    {
      nixosConfigurations = {
        wsl =
          let
            aspects = (import ./hosts/wsl).aspects;
          in
          nixpkgs.lib.nixosSystem {
            modules = nixosModules aspects ++ [
              ./hosts/wsl/hardware-configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.users.nixos = nixpkgs.lib.mkMerge (homeModules aspects);
              }
            ];

          };
      };

      homeConfigurations = {
        "wsl" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = homeModules (import ./hosts/wsl).aspects;
        };
      };
    };
}
