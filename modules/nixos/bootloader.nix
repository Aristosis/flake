{ config, lib, pkgs, ... }: {
  options.ari.bootloader.enable = lib.mkEnableOption "systemd-bootloader configuration";

  config = lib.mkIf config.myModules.bootloader.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
      consoleMode = "max";
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
