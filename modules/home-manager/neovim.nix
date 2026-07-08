{ config, lib, pkgs, ... }:

let
  mkIf = lib.mkIf;
in
{

  options.ari.home-manager.neovim.enable = lib.mkEnableOption "Enable neovim configuration";

  # config.xdg.configFile.neovim.source = mkIf config.ari.home-manager.neovim.enable ./config/neovim;
}
