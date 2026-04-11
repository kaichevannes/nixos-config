# nixos-config

## Installation

### NixOS
Boot into [Minimal ISO](https://nixos.org/download/)

```bash
sudo loadkeys uk
sudo nix --extra-experimental-features "nix-command flakes" run github:kaichevannes/nixos-config#install -- <host>
```

To rebuild use `sudo nixos-rebuild switch`. 
To rollback use `sudo nixos-rebuild switch --rollback`.

### WSL
Install [Wezterm nightly](https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe)

1. Enable WSL
```bash
# Elevated Powershell
wsl.exe --install --no-distribution
```
2. Download and run `nixos.wsl` from [the latest release](https://github.com/nix-community/NixOS-WSL/releases/latest)
3. Initialise system
```bash
sudo nix --extra-experimental-features "nix-command flakes" run github:kaichevannes/nixos-config#install -- sartre
```

## Secrets
```bash
nix-shell -p sops --run "sops secrets/secrets.yaml"
```

### Linux User Password
Store the result of `mkpasswd -m yescrypt <password>` in `secrets.yaml` under `password_<user>`.
