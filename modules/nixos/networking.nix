{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ari.networking.enable = lib.mkEnableOption "Enable NetworkManager and other networking configurations";

  config.networking = lib.mkIf config.ari.networking.enable {
    networkmanager.enable = true;
  };
}
