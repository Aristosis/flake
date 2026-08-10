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
    ./direnv.nix
  ];

  options.features.home-manager.cli.enable = lib.mkEnableOption "Enable CLI programs";
}
