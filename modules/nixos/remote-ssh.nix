{ config, lib, pkgs, ... }:
{
  options.ari.sshRemote.enable = lib.mkEnableOption "Enable remote ssh access";

  config.services = lib.mkIf config.ari.sshRemote.enable {
    openssh = {
      enable = true;
      settings = {};
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
        addresses = true;
      };
    };
  };
}
