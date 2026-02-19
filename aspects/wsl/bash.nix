{
  homeManager =
    { pkgs, ... }:
    {
      programs.bash = {
        enable = true;
        initExtra = ''
          if [ -z "$ZSH_VERSION" ]; then
              exec ${pkgs.zsh}/bin/zsh "$(shopt -q login_shell && echo --login)"
          fi
        '';
      };
    };
}
