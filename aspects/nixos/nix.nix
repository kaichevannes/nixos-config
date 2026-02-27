{
  nixos =
    { user, inputs, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      # https://github.com/anotherhadi/nixy/blob/main/nixos/nix.nix#L24-L54
      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        channel.enable = false;
        extraOptions = ''
          warn-dirty = false
        '';
        settings = {
          download-buffer-size = 262144000; # 250 MB (250 * 1024 * 1024)
          auto-optimise-store = true;
          substituters = [
            # high priority since it's almost always used
            "https://cache.nixos.org?priority=10"

            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
            "https://helix.cachix.org"
          ];
          trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
          ];
        };
        gc = {
          automatic = true;
          persistent = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };
    };
}
