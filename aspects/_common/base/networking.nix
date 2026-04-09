{ config, ... }:
{
  networking.hostName = config.meta.hostname;
}
