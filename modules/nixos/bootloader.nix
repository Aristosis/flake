{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.bootloader.enable = lib.mkEnableOption "systemd-bootloader configuration";

  config = lib.mkIf config.features.bootloader.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
      consoleMode = "max";
    };
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages =
      if config.features.graphicsDrivers.nvidia.enable
      then pkgs.linuxPackages_6_18
      else pkgs.linuxPackages_latest;
  };
}
