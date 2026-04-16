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
      git = {
        username = "Kai Chevannes";
        email = "chevannes.kai@gmail.com";
      };
    };
  };
}
