{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  config.programs.zoxide = mkIf config.features.home-manager.zoxide.enable {
    enable = true;
    enableZshIntegration = mkIf config.features.home-manager.zsh.enable true;
    options = ["--cmd cd"];
  };
}
