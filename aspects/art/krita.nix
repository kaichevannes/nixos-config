{
  nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        krita
      ];
    };
}
