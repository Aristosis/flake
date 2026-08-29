{
  config,
  ...
}:
{
  nix.settings = {
    substituters = ["https://cache.nixos-cuda.org"];
    trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="];
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      modesetting.enable = true;
      open = false;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}
