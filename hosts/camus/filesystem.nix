{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./persist.nix
  ];
}
