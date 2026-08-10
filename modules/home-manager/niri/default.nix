{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.niri.enable = lib.mkEnableOption "Enable niri configuration";
  config = mkIf config.features.home-manager.niri.enable {
    # imports = [ ];
    programs.waybar = import ./waybar.nix { inherit lib osConfig; };

    xdg.configFile.niri = {
      source = ../config/niri;
      recursive = true;
    };

    # Generated styling
    xdg.configFile."niri/cfg/stylix.kdl".text =
      lib.optionalString (config.stylix.cursor != null) ''
        cursor {
          xcursor-theme "${config.stylix.cursor.name}"
          xcursor-size ${builtins.toString config.stylix.cursor.size}
        }
      ''
      + ''
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

    home.packages = with pkgs; [

      awww                          # wallpaper
      xwayland-satellite            # X11 client support
      (pkgs.writeShellApplication { # Emoji picker script
        name = "fuzzel-emojis";
        runtimeInputs = with pkgs; [fuzzel coreutils wtype];
        text = ''
          emojis=$(cat ${../config/emojis})
          selected=$(echo "$emojis" | fuzzel -d -l 20)
          if [ -n "$selected" ]; then
            wtype "$(echo "$selected" | cut -d ' ' -f1)"
          fi
        '';
      })
    ];

    services = {
      mako.enable = true; # Notification (pop-ups specifically)
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        border.radius = 6; # TODO: make sure this lines up with niri
        border.width = 0;
        main = {
          prompt = "  ";
          use-bold = true;
          width = 26;
          lines = 12;
          vertical-pad = 5;
          horizontal-pad = 10;
          dpi-aware = true;
          terminal = "footclient";
          show-actions = false;
        };
      };
    };
  };
}
