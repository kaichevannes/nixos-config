{ inputs, requires, ... }:
{
  imports = requires [ "ssh" ] ++ [
    ./age.nix
    inputs.sops-nix.nixosModules.default
  ];
}
