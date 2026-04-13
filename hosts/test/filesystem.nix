{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ../camus/persist.nix
  ];
}
