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
          specialArgs = { inherit inputs hostname user; };

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

                  nix.settings.experimental-features = [
                    "nix-command"
                    "flakes"
                  ];
                }

                home-manager.nixosModules.home-manager
                {
                  home-manager.users.${user} = nixpkgs.lib.mkMerge (
                    homeModules aspects
                    ++ [
                      userConfig.homeManager
                      {
                        programs.home-manager.enable = true;
                        home.stateVersion = "25.11";
                      }
                    ]
                  );
                }
              ];
            in
            [
              ./hosts/${hostname}/hardware-configuration.nix

              {
                system.stateVersion = "25.11";
              }
            ]
            ++ nixosModules aspects
            ++ userModules;
        };
    in
    {
      nixosConfigurations = {
        camus = mkHost {
          hostname = "camus";
          aspects = [
            "nixos"
            "nvidia"
            "desktop"
            "dev"
            "virtualisation"
            "art"
          ];
          user = "cheva";
        };

        sartre = mkHost {
          hostname = "sartre";
          aspects = [
            "wsl"
            "dev"
          ];
          user = "cheva";
        };
      };
    };
}
