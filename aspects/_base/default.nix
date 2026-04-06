{
  imports = [
    ./home-manager.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./systemd-boot.nix
  ];

  system.stateVersion = "25.11";
}
