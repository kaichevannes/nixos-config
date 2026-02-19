{
  description = "Dendritic pattern without flake-parts or import-tree.";

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

      mkHost =
        {
          aspects,
          hostname,
          user ? null,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostname; };

          modules =
            let
              userConfig = import ./users/${user}.nix;
              userModules = nixpkgs.lib.optionals (user != null) [
                userConfig.nixos

                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                  };
                }

                home-manager.nixosModules.home-manager
                {
                  home-manager.users.${user} = nixpkgs.lib.mkMerge (
                    homeModules aspects
                    ++ [
                      userConfig.homeManager
                      {
                        programs.home-manager.enable = true;
                        home.stateVersion = "25.05";
                      }
                    ]
                  );
                }
              ];
            in
            [
              ./hosts/${hostname}/hardware-configuration.nix

              {
                system.stateVersion = "25.05";
              }
            ]
            ++ nixosModules aspects
            ++ userModules;
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          hostname = "desktop";
          aspects = [
            "nixos"
            "desktop"
            "dev"
          ];
          user = "cheva";
        };

        wsl = mkHost {
          hostname = "wsl";
          aspects = [
            "wsl"
            "dev"
          ];
          user = "cheva";
        };
      };
    };
}
