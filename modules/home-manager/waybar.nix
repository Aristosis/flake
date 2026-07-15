{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.waybar.enable = lib.mkEnableOption "Enable waybar configuration";

  config.programs.waybar = lib.mkIf config.features.home-manager.waybar.enable {
    enable = true;

    settings = [
      {
        position = "bottom";
        layer = "top";

        modules-left = [
          "niri/workspaces"
          "mpris"
        ];

        modules-center = [
          "niri/window"
        ];

        modules-right = [
          "tray"
          "network"
          "wireplumber"
          "clock"
        ] ++ (if config.networking.hostName == "nixos-laptop" then [ "battery" ] else []);

        tray = {
          icon-size = 16;
        };

        "niri/window" = {
          icon = true;
          icon-size = 18;
        };

        clock = {
          interval = 60;
          tooltip = true;
          format = "{:%a, %I:%M %p}";
          tooltip-format = "{:%a, %d/%m/%Y}";
        };

        network = {
          format-ethernet = "󰈁 {ifname}";
          format-wifi = "󰖩 {signalStrength}%";
          tooltip-format-wifi = "{ipaddr}/{essid}";
          tooltip-format-ethernet = "{ipaddr}/{ssid}";
          format-disconnected = "󰈂";
        };

        wireplumber = {
          tooltip = false;
          format = "{icon} {volume}%";
          format-muted = " ";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pwvucontrol";
          on-click-middle = "helvum";
          format-icons = ["" "" "" "" "" "" "" "" "" ""];
        };

        mpris = {
          format = " {dynamic}";
          format-paused = " {dynamic}";
          max-length = 40;
          interval = 1;
        };
      }
    ];
    style = ''
      * {
          font-family: Inter;
          font-size: 14px;
          color: @base05;
      }

      window#waybar {
          background: @base00;
      }

      button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 0;
      }

      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px @base0D;
      }

      #workspaces button {
          min-height: 0;
          min-width: 0;
          padding: 4px;
          padding-top: 3px;
          padding-bottom: 3px;
          background-color: transparent;
      }

      #workspaces button.focused, #workspaces button.active {
          box-shadow: inset 0 -1px @base0B;
      }

      #workspaces button.urgent {
          background-color: @base08;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #mpd {
          padding: 0 10px;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          background: transparent;
          border-bottom: 4px solid @base0A;
      }

      #network {
          border-bottom: 4px solid @base0C;
      }

      #network.disconnected {
          border-bottom: 4px solid @base09;
      }

      #wireplumber {
          border-bottom: 4px solid @base0D;
      }

      #wireplumber.muted {
          border-bottom: 4px solid @base03;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @base0E;
      }
    '';
  };
}
