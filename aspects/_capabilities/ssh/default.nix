{ requires, ... }:
{
  imports = requires [ ] ++ [
    ./ssh.nix
    ./pass-cli.nix
  ];
}
