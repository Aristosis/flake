{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.ari.home-manager.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  config.programs.zoxide = mkIf config.ari.home-manager.zoxide.enable {
    enable = true;
    enableZshIntegration = mkIf config.ari.home-manager.zsh.enable true;
    options = ["--cmd cd"];
  };
}
