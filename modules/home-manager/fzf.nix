{ config, lib, pkgs, ... }:

let
  mkIf = lib.mkIf;
in
{

  options.ari.home-manager.fzf.enable = lib.mkEnableOption "Enable fzf configuration";

  config.programs.fzf = mkIf config.ari.home-manager.fzf.enable {
    enable = true;
    enableZshIntegration = mkIf config.ari.home-manager.zsh.enable true;

    colors = {};
  };
}
