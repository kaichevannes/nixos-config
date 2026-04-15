{
  meta = {
    username = "cheva";
    description = "NixOS Desktop";
  };

  profiles = {
    art.enable = true;
    desktop.enable = true;
    dev = {
      enable = true;
      gitUsername = "Kai Chevannes";
      gitEmail = "chevannes.kai@gmail.com";
    };
    virtualisation.enable = true;
  };
}
