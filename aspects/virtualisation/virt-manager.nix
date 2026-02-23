{
  nixos =
    { pkgs, ... }:
    {
      programs.virt-manager = {
        enable = true;
      };
    };
}
