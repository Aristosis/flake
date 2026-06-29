{ config, lib, pkgs, ... }:

{
  options.ari.home-manager.fuzzel.enable = lib.mkEnableOption "Enable fuzzel";

  config.programs.fuzzel = lib.mkIf config.ari.home-manager.fuzzel.enable {
    settings = {

      main = {
        font = "Inter:size=13";
        use-bold = true;
        prompt = "  ";
        width = 26;
        lines = 12;
        vertical-pad = 5;
        horizontal-pad = 10;
        terminal =
          if config.programs.foot.enable then "footclient"
          else if config.programs.kitty.enable then "kitty"
          else "";
        dpi-aware = true;
        show-actions = false;
        border = {
          radius = 12;
          width = 0;
        };
      };
    };
  };
}
