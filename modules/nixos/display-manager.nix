{ config, lib, pkgs, ... }:
{
  options.ari.displayManager.enable = lib.mkEnableOption "Enable display manager configuration";

  config.services.displayManager.ly.enable = lib.mkIf config.ari.displayManager.enable true;
}
