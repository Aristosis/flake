{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.niri.enable = lib.mkEnableOption "Enable niri configuration";

  config = mkIf config.features.home-manager.niri.enable {
    xdg.configFile.niri = {
      source = ./config/niri;
      recursive = true;
    };
    xdg.configFile."niri/cfg/stylix.kdl".text =
      lib.optionalString (config.stylix.cursor != null) ''
      cursor {
        xcursor-theme "${config.stylix.cursor.name}"
        xcursor-size ${builtins.toString config.stylix.cursor.size}
      }
    '' +
    ''
    layout {
      border {
        active-color   "#${config.lib.stylix.colors.base0D}"
        inactive-color "#${config.lib.stylix.colors.base03}"
        urgent-color   "#${config.lib.stylix.colors.red}"
      }
      tab-indicator {
        active-color   "#${config.lib.stylix.colors.base0D}"
        inactive-color "#${config.lib.stylix.colors.base03}"
        urgent-color   "#${config.lib.stylix.colors.red}"
      }
    }
    '';

    home.packages = with pkgs;
    [
      xwayland-satellite
      awww
    ];
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          use-bold = true;
          prompt = "  ";
          width = 26;
          lines = 12;
          vertical-pad = 5;
          horizontal-pad = 10;
          terminal = "ghostty +new-window";
          dpi-aware = true;
          show-actions = false;
        };
        border = {
          radius = 12;
          width = 0;
        };
      };
    };
  };
}
