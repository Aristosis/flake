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
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        # Files be under user perms instead of root!
        User = "ari";
        Group = "users";

        ExecStart = ''
        ${pkgs.copyparty}/bin/copyparty \
        v /home/ari/Media/Music:/Music:r \
        --zeroconf
        '';

        Restart = "on-failure";
      };
    };
    services = {
      avahi.extraServiceFiles.copyparty = ''
        <?xml version="1.0" standalone='no'?>
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
        <name>copyparty</name>
        <service>
        <type>_http._tcp</type>
        <port>80</port>
        </service>
        </service-group>
        '';
      nginx = {
        enable = true;
        recommendedProxySettings = true;
        virtualHosts."copyparty.local" = {
          locations."/" = {
            proxyPass = "http://127.0.0.1:3923";
            proxyWebsockets = true;
            # fix copyparty halts downloads;
            extraConfig = "client_max_body_size 0;"; 
          };
        };
      };
    };
  };
}
