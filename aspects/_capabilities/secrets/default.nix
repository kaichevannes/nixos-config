{ inputs, ... }:
{
  imports = [
    # Requires
    ../ssh

    # Modules
    ./age.nix

    # sops-nix
    inputs.sops-nix.nixosModules.default
  ];
}
