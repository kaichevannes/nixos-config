{ config, ... }:
{
  services.getty.autologinUser = config.meta.username;
}
