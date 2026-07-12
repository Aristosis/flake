{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.sshRemote.enable = lib.mkEnableOption "Enable remote ssh access";

  config.services = lib.mkIf config.features.sshRemote.enable {
    openssh = {
      enable = true;
      settings = {};
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
      extraServiceFiles = {
      };
    };
  };
}
