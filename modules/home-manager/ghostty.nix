{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal emulator";

  config = lib.mkIf config.features.home-manager.ghostty.enable {
    programs.ghostty = {
      enable = true;
    };
  };
}
