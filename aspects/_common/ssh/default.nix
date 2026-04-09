{ requires, ... }:
{
  imports = requires [ "secrets" ] ++ [
    ./ssh.nix
    ./pass-cli.nix
  ];
}
