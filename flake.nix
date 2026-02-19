{
  description = "Dendritic pattern without dependencies";

  inputs = {
    nixpgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }:
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
            aspects = [
              "wsl"
              "cheva"
              "dev"
            ];
          in
          nixpkgs.lib.nixosSystem {
            modules = nixosModules aspects ++ [
              ./hosts/wsl/hardware-configuration.nix

              home-manager.nixosModules.home-manager
              {
                home-manager.users.cheva = nixpkgs.lib.mkMerge (homeModules aspects);
              }

              nixos-wsl.nixosModules.default
              {
                wsl.enable = true;
                wsl.defaultUser = "cheva";
              }
            ];
          };
      };
    };
}
