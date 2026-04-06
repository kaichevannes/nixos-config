{
  imports = [
    # Capabilities
    ../_capabilities/ssh

    # Modules
    ./bat.nix
    ./claude.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./helix
    ./lazygit
    ./starship.nix
    ./tmux.nix
    ./utils.nix
    ./yazi
    ./zoxide.nix
    ./zsh.nix
  ];
}
