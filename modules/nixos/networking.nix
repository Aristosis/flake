{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.networking.enable = lib.mkEnableOption "Enable NetworkManager and other networking configurations";

  config.networking = lib.mkIf config.features.networking.enable {
    networkmanager.enable = true;
  };
}
