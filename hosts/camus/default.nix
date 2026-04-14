{
  meta = {
    username = "cheva";
    description = "NixOS Desktop";
  };

  profiles = {
    dev = {
      enable = true;
      gitUsername = "Kai Chevannes";
      gitEmail = "chevannes.kai@gmail.com";
    };
    browser.enable = true;
    art.enable = true;
    virtualisation.enable = true;
  };
}
