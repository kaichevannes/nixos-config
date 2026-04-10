{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.default ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.age.keyFile = "/persist/var/lib/sops-nix/key.txt";
  sops.secrets = (import ../../../secrets/manifest.nix { inherit config; });

  environment.variables.SOPS_AGE_KEY_FILE = "/persist/var/lib/sops-nix/key.txt";
}
