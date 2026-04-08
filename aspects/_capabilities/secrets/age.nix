{ config, ... }:
{
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.secrets = (import ../../../secrets/manifest.nix { inherit config; });

  environment.variables.SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
}
