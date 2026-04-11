{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.impermanence.nixosModules.impermanence
    ./disko.nix
    ./persist.nix
  ];
}
