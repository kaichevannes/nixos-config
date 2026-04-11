{ lib, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
  environment.variables.SOPS_AGE_KEY_FILE = "/persist/var/lib/sops-nix/key.txt";

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;

  sops.secrets = lib.mapAttrs' (filename: _: {
    name = lib.removeSuffix ".sops" filename;
    value = {
      format = "binary";
      sopsFile = ../../../secrets + "/${filename}";
    };
  }) (lib.filterAttrs (name: _: lib.hasSuffix ".sops" name) (builtins.readDir ../../../secrets));
}
