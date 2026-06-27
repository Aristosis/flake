{ config, lib, pkgs, ... }:
{
  options.ari.displayManager.enable = lib.mkEnableOption "Enable display manager configuration";

  config.services.displayManager.ly = lib.mkIf config.ari.displayManager.enable {
    enable = true;
  };
}
