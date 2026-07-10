{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.fzf.enable = lib.mkEnableOption "Enable fzf configuration";

  config.programs.fzf = mkIf config.features.home-manager.fzf.enable {
    enable = true;
    enableZshIntegration = mkIf config.features.home-manager.zsh.enable true;
  };
}
