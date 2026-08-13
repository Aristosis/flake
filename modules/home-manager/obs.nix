{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.obs.enable = lib.mkEnableOption "Enable OBS configuration";

  config = mkIf config.features.home-manager.obs.enable {
    home.packages = with pkgs; [
      (obs-studio.override {
        cudaSupport = osConfig.features.graphicsDrivers.nvidia.enable;
      })
    ];
  };
}
