{ config, inputs, ... }:
let
  # ageKeyFile = "/persist/var/lib/sops-nix/key.txt";
  ageKeyFile = "/var/lib/sops-nix/key.txt";
in
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.keyFile = ageKeyFile;
  sops.secrets = (import ../../../secrets/manifest.nix { inherit config; });

  environment.variables.SOPS_AGE_KEY_FILE = ageKeyFile;
}
