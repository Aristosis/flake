{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ari.home-manager.fuzzel.enable = lib.mkEnableOption "Enable fuzzel";
  config.stylix.targets.fuzzel.fonts.override =
  let
    monospace = config.stylix.fonts.monospace.package;
  in
  lib.mkIf config.ari.home-manager.fuzzel.enable 
  {
    # sizes.popups = ;
    serif.package = monospace;
  };
  config.programs.fuzzel = lib.mkIf config.ari.home-manager.fuzzel.enable {
    enable = true;
    settings = {
      main = {
        use-bold = true;
        prompt = "  ";
        width = 26;
        lines = 12;
        vertical-pad = 5;
        horizontal-pad = 10;
        terminal =
          if config.programs.foot.enable
          then "footclient"
          else if config.programs.kitty.enable
          then "kitty"
          else "";
        dpi-aware = true;
        show-actions = false;
      };
      border = {
        radius = 12;
        width = 0;
      };
      # colors = {
      #   background = "141218ff";
      #   text = "e7e0e8ff";
      #   prompt = "ccc2dbff";
      #   placeholder = "f0b8c6ff";
      #   input = "d1bcfdff";
      #   match = "f0b8c6ff";
      #   selection = "d1bcfdff";
      #   selection-text = "141218ff";
      #   selection-match = "37265cff";
      #   counter = "ccc2dbff";
      #   border = "d1bcfdff";
      # };
    };
  };
}
