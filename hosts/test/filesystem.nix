{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.home-manager.nixosModules.home-manager
    ./disko.nix
  ];

  services.openssh.enable = true;

  users.users.cheva = {
    isNormalUser = true;
    hashedPassword = "$6$yzZCgIQxU89YMHGH$iuE62z6bkIQPyEP.XAI44Tkho9CRgSkA2onHis.TV4Pd8zdDvgm0wZbbwKeOVO/9Oh/JVpbTtcIE3IZfjjZ.D/";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;

    users.cheva = {
      programs.home-manager.enable = true;
      home.stateVersion = "25.11";
    };
  };
}
