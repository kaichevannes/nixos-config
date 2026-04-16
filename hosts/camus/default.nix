{
  meta = {
    username = "cheva";
    description = "NixOS Desktop";
  };

  profiles = {
    desktop = {
      enable = true;
      art.enable = true;
      vms.enable = true;
    };
    dev = {
      enable = true;
      docker.enable = true;
      gitUsername = "Kai Chevannes";
      gitEmail = "chevannes.kai@gmail.com";
    };
  };
}
