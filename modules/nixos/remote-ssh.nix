{ config, lib, pkgs, ... }:
{
  options.ari.sshRemote.enable = lib.mkEnableOption "Enable remote ssh access";

  config.services.openssh = lib.mkIf config.ari.sshRemote.enable {
    enable = true;
    settings = {};
  };
}
