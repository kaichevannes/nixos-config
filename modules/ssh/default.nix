{ lib, ... }:
{
  options.modules.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  imports = [
    ./ssh.nix
    ./pass-cli.nix
  ];
}
