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

  config.programs.fuzzel = lib.mkIf config.features.home-manager.fuzzel.enable {
    enable = true;
    settings = {
      main = {
        use-bold = true;
        prompt = "  ";
        width = 26;
        lines = 12;
        vertical-pad = 5;
        horizontal-pad = 10;
        terminal = "footclient";
        dpi-aware = true;
        show-actions = false;
      };
      border = {
        radius = 12;
        width = 0;
      };
    };
  };
}
