{ lib, inputs, ... }:
let
  # ageKeyFile = "/persist/var/lib/sops-nix/key.txt";
  ageKeyFile = "/var/lib/sops-nix/key.txt";
in
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  sops.age.keyFile = ageKeyFile;
  environment.variables.SOPS_AGE_KEY_FILE = ageKeyFile;

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;

  sops.secrets = lib.mapAttrs' (filename: _: {
    name = lib.removeSuffix ".sops" filename;
    value = {
      format = "binary";
      sopsFile = ../../../secrets + "/${filename}";
    };
  }) (lib.filterAttrs (name: _: lib.hasSuffix ".sops" name) (builtins.readDir ../../../secrets));
}
