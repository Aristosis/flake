{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.copyparty.enable = lib.mkEnableOption "Enable copyparty service";

  config = lib.mkIf config.features.copyparty.enable {
    environment.systemPackages = with pkgs; [copyparty nginx];
    networking.firewall.allowedTCPPorts = [80 443];
    systemd.services.copyparty = {
      description = "copy the party";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        # Files be under user perms instead of root!
        User = "ari";
        Group = "users";
        AmbientCapabilities = ["CAP_NET_BIND_SERVICE"];

        ExecStart = ''
          ${pkgs.copyparty}/bin/copyparty \
          -v /home/ari/Media/Music:/Music:r:rw,ari \
          --rproxy -1 \
          --rp-loc /copyparty \
          -a ari:boing \
          -e2dsa
          -z \
        '';

        Restart = "on-failure";
        RestartSec = "5s";
      };
    };

    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts."nixos-desktop" = {
        locations."/copyparty/" = {
          proxyPass = "http://127.0.0.1:3923";
          proxyWebsockets = true; # needed if you need to use WebSocket
        };
      };
    };
  };
}
