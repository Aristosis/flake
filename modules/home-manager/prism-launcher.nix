
{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.prismLauncher.enable = lib.mkEnableOption "Enable Prism Launcher";

  config = mkIf config.features.home-manager.prismLauncher.enable {
    home.packages = with pkgs; [
      prismlauncher
      temurin-jre-bin-17
    ];
  };
}
