{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ari.home-manager.foot.enable = lib.mkEnableOption "Enable foot terminal emulator";

  config.programs.foot = lib.mkIf config.ari.home-manager.foot.enable {
    enable = true;
    server.enable = true;

    settings = {
      main.font = "Iosevka:size=14";

      colors-dark = {
        alpha = 0.9;
        foreground = "e7e0e8";
        background = "0f0d13";
        selection-foreground = "332d41";
        selection-background = "ccc2db";
      };
    };
  };
}
