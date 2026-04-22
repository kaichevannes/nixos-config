{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.desktop.music = {
    enable = lib.mkEnableOption "music";
  };

  config = lib.mkIf config.profiles.desktop.music.enable {
    modules.secrets.enable = true;
    modules.secrets.homeFiles = [ ".config/REAPER/reaper-license.rk" ];
    modules.persist.homeDirectories = [ ".config/REAPER" ];

    services.pipewire.jack.enable = true;

    environment.systemPackages = [
      (pkgs.symlinkJoin {
        name = "reaper-jackwrapped";
        paths = [ pkgs.reaper ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          for b in "$out/bin/"*; do
            wrapProgram "$b" \
              --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
          done
        '';
      })
    ];
  };
}
