{
  nixos = {
    home-manager.users.cheva = { ... }: { };
  };

  homeManager = {
    home.username = "cheva";
    home.homeDirectory = "/home/cheva";

    programs.git.settings = {
      user.name = "Kai Chevannes";
      user.email = "chevannes.kai@gmail.com";
    };
  };
}
