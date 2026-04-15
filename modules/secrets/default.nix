{
  config,
  inputs,
  lib,
  ...
}:
{
  options.modules.secrets = {
    enable = lib.mkEnableOption "secrets";
    systemFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    homeFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config =
    let
      cfg = config.modules.secrets;
    in
    lib.mkIf cfg.enable {
      sops.defaultSopsFile = ../../secrets/secrets.yaml;
      sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
      sops.secrets = builtins.listToAttrs (
        map (path: {
          name = builtins.baseNameOf path;
          value = {
            format = "binary";
            sopsFile = ../../secrets/${builtins.baseNameOf path}.sops;
            path = path;
          };
        }) cfg.systemFiles
      );

      home-manager.sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
        (
          { config, ... }:
          {
            sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
            sops.secrets = builtins.listToAttrs (
              map (path: {
                name = builtins.baseNameOf path;
                value = {
                  format = "binary";
                  sopsFile = ../../secrets/${builtins.baseNameOf path}.sops;
                  path = "${config.home.homeDirectory}/${path}";
                };
              }) cfg.homeFiles
            );
          }
        )
      ];

      environment.variables.SOPS_AGE_KEY_FILE = "/persist/var/lib/sops-nix/key.txt";
    };

  imports = [ inputs.sops-nix.nixosModules.default ];
}
