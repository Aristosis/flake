{ config, lib, pkgs, ... }:

let
  mkIf = lib.mkIf;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{

  options.ari.home-manager.neovim.enable = lib.mkEnableOption "Enable neovim configuration";

  config = mkIf config.ari.home-manager.neovim.enable {
    home.packages = with pkgs; [ neovim ];
    xdg.configFile.nvim.source = mkSymlink "${config.home.homeDirectory}/flake/modules/home-manager/config/nvim";
  };
}
