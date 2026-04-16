{
  meta = {
    username = "nixos";
    description = "WSL";
  };

  profiles = {
    dev = {
      enable = true;
      git = {
        username = "Kai Chevannes";
        email = "chevannes.kai@gmail.com";
      };
    };
  };
}
