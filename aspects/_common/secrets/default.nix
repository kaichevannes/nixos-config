{ inputs, requires, ... }:
{
  imports = requires [ ] ++ [
    ./age.nix
    inputs.sops-nix.nixosModules.default
  ];
}
