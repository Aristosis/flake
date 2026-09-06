{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    user = "ari";
    dataDir = "/home/ari/.local/state/syncthing";
    settings = {
      devices.phone.id = "RINSL5F-4IERP4O-UFRMGVU-OFQOSF2-XCLL2HB-ZSVBXMP-DDXGKNR-ON5TEQQ";
      options.urAccepted = -1;
      gui = {
        user = "ari";
        password = "bingus";
      };
      folders = {
        "documents" = {
          versioning.type = "simple";
          versioning.params.cleanoutDays = "365";
          id = "documents";
          path = "~/media/hdd/documents";
          devices = [ "phone" ];
        };

        "music" = {
          versioning.type = "simple";
          versioning.params.cleanoutDays = "365";
          id = "music";
          path = "~/media/hdd/music";
          devices = [ "phone" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
}
