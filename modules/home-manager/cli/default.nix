{
  lib,
  config,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in
{
  imports = [
    ./misc.nix
    ./git.nix
    ./direnv.nix
    ./neovim.nix
  ];

  options.features.home-manager.cli.enable = lib.mkEnableOption "Enable CLI programs";
}
