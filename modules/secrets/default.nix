{
  config,
  inputs,
  lib,
  ...
}:
{
  options.modules.secrets = {
    enable = lib.mkEnableOption "secrets";
  };

  config = lib.mkIf config.modules.secrets.enable {
    sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
    environment.variables.SOPS_AGE_KEY_FILE = "/persist/var/lib/sops-nix/key.txt";

    sops.defaultSopsFile = ../../secrets/secrets.yaml;

    home-manager.sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      {
        sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
      }
    ];
  };

  imports = [ inputs.sops-nix.nixosModules.default ];
}
