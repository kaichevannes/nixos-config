{
  nixos =
    { config, pkgs, ... }:
    {
      services.getty.autologinUser = "cheva";
      programs.zsh.enable = true;
      users = {
        defaultUserShell = pkgs.zsh;

        users.cheva = {
          isNormalUser = true;
          description = "Kai Chevannes";
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
