{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.ari.home-manager.eza.enable = lib.mkEnableOption "Enable eza configuration";

  config.programs.eza = mkIf config.ari.home-manager.eza.enable {
    enable = true;
    enableZshIntegration = mkIf config.ari.home-manager.zsh.enable true;

    git = true;
    icons = "auto";
  };
}
