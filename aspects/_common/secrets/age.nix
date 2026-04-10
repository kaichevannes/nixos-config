{ config, ... }:
let
  impermanenceEnabled = config.environment.persistence != { };
  ageKeyFile =
    if impermanenceEnabled then "/persist/var/lib/sops-nix/key.txt" else "/var/lib/sops-nix/key.txt";
in
{
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.keyFile = ageKeyFile;
  sops.secrets = (import ../../../secrets/manifest.nix { inherit config; });

  environment.variables.SOPS_AGE_KEY_FILE = ageKeyFile;
}
