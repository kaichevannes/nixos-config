{ config, ... }:
{
  hardware.facter.reportPath = ../../hosts/${config.meta.hostname}/facter.json;
}
