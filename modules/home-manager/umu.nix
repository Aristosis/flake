{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.umu.enable = lib.mkEnableOption "Enable umu configuration";

  config = mkIf config.features.home-manager.umu.enable {
    home.packages = with pkgs; [
      winetricks
      mangohud
      gamemode
      umu-launcher
    ];
    home.sessionVariables.PROTONPATH = "${pkgs.proton-ge-bin.steamcompattool}";
  };
}
