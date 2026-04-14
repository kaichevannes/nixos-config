{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = lib.mkIf config.modules.user.enable {
    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${config.meta.username} = {
        programs.home-manager.enable = true;
        home.stateVersion = "25.11";
      };
    };
  };
}
