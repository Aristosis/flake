{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.mpv.enable = lib.mkEnableOption "Enable MPV";

  config.programs.mpv = lib.mkIf config.features.home-manager.mpv.enable {
    enable = true;
  };
}
