{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    user = "ari";
    dataDir = "/home/ari/.local/state/syncthing";
    settings = {
      devices.phone.id = "RINSL5F-4IERP4O-UFRMGVU-OFQOSF2-XCLL2HB-ZSVBXMP-DDXGKNR-ON5TEQQ";
      options.urAccepted = -1;
      folders = {
        "/home/ari/Media/Documents" = {
          versioning.type = "simple";
          versioning.params.cleanoutDays = 365;
          id = "documents";
          devices = [ "phone" ];
        };

        "/home/ari/Media/Music" = {
          versioning.type = "simple";
          versioning.params.cleanoutDays = 365;
          id = "music";
          devices = [ "phone" ];
        };
      };
      gui = {
        user = "ari";
        password = "bingus";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
}
