{ config, lib, pkgs, ... }:
{
  options.ari.graphicsDrivers.enable = lib.mkEnableOption "Enable graphics drivers configuration";
  options.ari.graphicsDrivers.nvidia.enable = lib.mkEnableOption "Enable Nvidia graphics drivers configuration";


  config = lib.mkIf config.ari.graphicsDrivers.enable {

    nix.settings = lib.mkIf config.ari.graphicsDrivers.nvidia.enable {
      substituters = [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };

    hardware = {
      graphics.enable = true;
      nvidia = lib.mkIf config.ari.graphicsDrivers.nvidia.enable {
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        modesetting.enable = true;
        open = false;
      };
    };

    # services.xserver.videoDrivers = lib.mkIf config.ari.graphicsDrivers.nvidia.enable [ "nvidia" ];

    services.xserver.videoDrivers = if config.ari.graphicsDrivers.nvidia.enable
    then [ "nvidia" ]
    else [ "amdgpu" ];
  };

}
