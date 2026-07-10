{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.niri.enable = lib.mkEnableOption "Enable niri configuration";

  config.xdg.configFile.niri.source = mkIf config.features.home-manager.niri.enable ./config/niri;
}
