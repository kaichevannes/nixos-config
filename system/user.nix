{ config, pkgs, ... }:
{
  programs.fish.enable = true;
  users = {
    defaultUserShell = pkgs.fish;

    users.${config.var.username} = {
      isNormalUser = true;
      description = "${config.var.git.user}";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
