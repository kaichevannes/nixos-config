# On WSL we don't need to partition with disko
{ ... }:
{
  fileSystems."/" = {
    device = "/";
    fsType = "ext4";
  };
}
