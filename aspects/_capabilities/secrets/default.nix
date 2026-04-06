{ inputs, ... }:
{
  imports = [
    # Capabilities
    ../ssh

    # Modules
    ./age.nix

    # sops-nix
    inputs.sops-nix.nixosModules.default
  ];
}
