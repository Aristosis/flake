{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.fonts.enable = lib.mkEnableOption "Enable font configurations";
  config.fonts = lib.mkIf config.features.fonts.enable {
    enableDefaultPackages = true;
    packages = with pkgs; [
      iosevka
      inter
      nerd-fonts.symbols-only
    ];
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting = {
        enable = true;
        style = "slight";
      };
    };
  };
}
