{ ... }:
{
  programs.zsh.initContent = ''
    if [[ -o interactive ]] then
      {
        pass-cli test >/dev/null 2>&1 || echo "Proton Pass CLI is not authenticated. Run 'pass-cli login'."
      } &!
    fi
  '';

  programs.zsh.shellAliases = {
    pass-login = "pass-cli login && systemctl --user start proton-pass-ssh-agent";
  };

  services.ssh-agent = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "yes";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts ~/.ssh/.managed_known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };

  home.file.".ssh/.managed_known_hosts" = {
    text = ''
      github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    '';
    force = true;
  };
}
