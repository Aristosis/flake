{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.displayManager.enable = lib.mkEnableOption "Enable display manager configuration";

  config.services.displayManager.ly = lib.mkIf config.features.displayManager.enable {
    enable = true;
  };
}
