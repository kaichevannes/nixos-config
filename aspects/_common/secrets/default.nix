{ requires, ... }:
{
  imports = requires [ ] ++ [
    ./sops-nix.nix
  ];
}
