{ config, lib, pkgs, ... }:

let
  mkIf = lib.mkIf;
in
{

  options.ari.home-manager.niri.enable = lib.mkEnableOption "Enable niri configuration";

  config.xdg.configFile.niri.source = mkIf config.ari.home-manager.niri.enable ./config/niri;
}
