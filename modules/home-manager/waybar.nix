{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ari.home-manager.waybar.enable = lib.mkEnableOption "Enable waybar configuration";

  config.programs.waybar = lib.mkIf config.ari.home-manager.waybar.enable {
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
        ];

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

    # style = ''
    #
    #   @define-color background #141218;
    #   @define-color error #ffb4ab;
    #   @define-color error_container #93000a;
    #   @define-color inverse_on_surface #322f35;
    #   @define-color inverse_primary #66558e;
    #   @define-color inverse_surface #e7e0e8;
    #   @define-color on_background #e7e0e8;
    #   @define-color on_error #690005;
    #   @define-color on_error_container #ffdad6;
    #   @define-color on_primary #37265c;
    #   @define-color on_primary_container #eaddff;
    #   @define-color on_primary_fixed #220f46;
    #   @define-color on_primary_fixed_variant #4e3d75;
    #   @define-color on_secondary #332d41;
    #   @define-color on_secondary_container #e9def8;
    #   @define-color on_secondary_fixed #1e192b;
    #   @define-color on_secondary_fixed_variant #4a4358;
    #   @define-color on_surface #e7e0e8;
    #   @define-color on_surface_variant #cbc4cf;
    #   @define-color on_tertiary #4a2531;
    #   @define-color on_tertiary_container #ffd9e2;
    #   @define-color on_tertiary_fixed #31101c;
    #   @define-color on_tertiary_fixed_variant #643b47;
    #   @define-color outline #948f99;
    #   @define-color outline_variant #49454e;
    #   @define-color primary #d1bcfd;
    #   @define-color primary_container #4e3d75;
    #   @define-color primary_fixed #eaddff;
    #   @define-color primary_fixed_dim #d1bcfd;
    #   @define-color scrim #000000;
    #   @define-color secondary #ccc2db;
    #   @define-color secondary_container #4a4358;
    #   @define-color secondary_fixed #e9def8;
    #   @define-color secondary_fixed_dim #ccc2db;
    #   @define-color shadow #000000;
    #   @define-color source_color #6642b1;
    #   @define-color surface #141218;
    #   @define-color surface_bright #3b383e;
    #   @define-color surface_container #211f24;
    #   @define-color surface_container_high #2b292f;
    #   @define-color surface_container_highest #36343a;
    #   @define-color surface_container_low #1d1b20;
    #   @define-color surface_container_lowest #0f0d13;
    #   @define-color surface_dim #141218;
    #   @define-color surface_tint #d1bcfd;
    #   @define-color surface_variant #49454e;
    #   @define-color tertiary #f0b8c6;
    #   @define-color tertiary_container #643b47;
    #   @define-color tertiary_fixed #ffd9e2;
    #   @define-color tertiary_fixed_dim #f0b8c6;
    #
    #   * {
    #   	font-family: Inter;
    #     font-size: 14px;
    #   	color: @on_background;
    #   }
    #
    #
    #   window#waybar {
    #   	/* background: rgba(0, 0, 0, 0.6); */
    #       background: @background;
    #   }
    #
    #   button {
    #     box-shadow: inset 0 -3px transparent;
    #     border: none;
    #     border-radius: 0;
    #   }
    #
    #   button:hover {
    #     background: inherit;
    #     box-shadow: inset 0 -3px @primary;
    #   }
    #
    #   #workspaces button {
    #   	min-height: 0;
    #   	min-width: 0;
    #   	padding: 4px;
    #   	padding-top: 3px;
    #   	padding-bottom: 3px;
    #     background-color: transparent;
    #   }
    #
    #   #workspaces button.focused, #workspaces button.active {
    #     box-shadow: inset 0 -3px @primary_fixed_dim;
    #   }
    #
    #   #workspaces button.urgent {
    #   	background-color: @on_error;
    #   }
    #
    #   #clock,
    #   #battery,
    #   #cpu,
    #   #memory,
    #   #disk,
    #   #temperature,
    #   #backlight,
    #   #network,
    #   #pulseaudio,
    #   #wireplumber,
    #   #custom-media,
    #   #tray,
    #   #mode,
    #   #idle_inhibitor,
    #   #scratchpad,
    #   #power-profiles-daemon,
    #   #mpd {
    #     padding: 0 10px;
    #   }
    #
    #   #window,
    #   #workspaces {
    #     margin: 0 4px;
    #   }
    #
    #   /* If workspaces is the leftmost module, omit left margin */
    #   .modules-left > widget:first-child > #workspaces {
    #     margin-left: 0;
    #   }
    #
    #   /* If workspaces is the rightmost module, omit right margin */
    #   .modules-right > widget:last-child > #workspaces {
    #     margin-right: 0;
    #   }
    #
    #   #clock {
    #     background: transparent;
    #   	border-bottom: 4px solid @inverse_primary;
    #   }
    #
    #   #network {
    #     border-bottom: 4px solid @tertiary;
    #   }
    #
    #   #network.disconnected {
    #     border-bottom: 4px solid @on_tertiary;
    #   }
    #
    #   #wireplumber {
    #     border-bottom: 4px solid @primary;
    #   }
    #
    #   #wireplumber.muted {
    #     border-bottom: 4px solid @on_primary;
    #   }
    #
    #   #tray > .passive {
    #     -gtk-icon-effect: dim;
    #   }
    #
    #   #tray > .needs-attention {
    #     -gtk-icon-effect: highlight;
    #     background-color: @primary;
    #   }
    # '';
  };
}
