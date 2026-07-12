{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.copyparty.enable = lib.mkEnableOption "Enable copyparty service";

  config = lib.mkIf config.features.copyparty.enable {
    systemd.services.copyparty = {
      description = "copy the party";
      after = [ "network.target" ];
    };
  };
}
