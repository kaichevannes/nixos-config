{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    profiles.dev = {
      enable = lib.mkEnableOption "dev";
      gitUsername = lib.mkOption { type = lib.types.str; };
      gitEmail = lib.mkOption { type = lib.types.str; };
    };
  };

  config = lib.mkIf config.profiles.dev.enable {
    modules.user.enable = true;
    modules.ssh.enable = true;

    modules.persist.homeDirectories = [
      "Projects"
      ".local/share/zoxide"
    ];

    home-manager.sharedModules = [
      {
        home.packages = with pkgs; [
          ripgrep
          tokei
        ];

        programs.eza = {
          enable = true;
          enableZshIntegration = true;
        };
        programs.fzf = {
          enable = true;
          enableZshIntegration = true;
        };
        programs.zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
      }
    ];
  };

  imports = [
    ./ai.nix
    ./editor
    ./file-explorer
    ./git
    ./multiplexer.nix
    ./prompt.nix
    ./shell.nix
  ];
}
