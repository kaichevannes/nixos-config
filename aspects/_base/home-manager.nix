{ inputs, user, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${user} = {
      programs.home-manager.enable = true;
      home.stateVersion = "25.11";
    };
  };
}
