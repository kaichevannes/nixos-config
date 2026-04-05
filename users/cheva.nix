{
  nixos =
    { config, pkgs, ... }:
    {
      sops.secrets.password_cheva.neededForUsers = true;

      programs.zsh.enable = true;
      users = {
        defaultUserShell = pkgs.zsh;

        users.cheva = {
          isNormalUser = true;
          description = "Kai Chevannes";
          hashedPasswordFile = config.sops.secrets.password_cheva.path;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
      };
    };

  homeManager =
    { ... }:
    {
      programs.git.settings = {
        user.name = "Kai Chevannes";
        user.email = "chevannes.kai@gmail.com";
      };
    };
}
