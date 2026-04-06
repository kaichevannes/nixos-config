{ config, inputs, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.default ];

  wsl.enable = true;
  wsl.defaultUser = config.meta.username;
}
