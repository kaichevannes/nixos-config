{ ... }:
{
  home-manager.sharedModules = [
    {
      programs.claude-code = {
        enable = true;
        settings = {
          env.CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
          permissions.defaultMode = "plan";
          spinnerVerbs = {
            mode = "replace";
            verbs = [ "Processing" ];
          };
        };
      };
    }
  ];
}
