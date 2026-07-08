{ config, lib, pkgs, ... }:
{
  options.ari.tlp.enable = lib.mkEnableOption "Enable TLP power management";

  config = lib.mkIf config.ari.tlp.enable {
    services.tlp = {
      enable = true;
    };
  };
}
