{
  imports = [
    # Requires
    ../_capabilities/user

    # Modules
    ./docker.nix
    ./libvirtd.nix
    ./virt-manager.nix
  ];
}
