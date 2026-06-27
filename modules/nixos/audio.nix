{ config, lib, pkgs, ... }:
{
  options.ari.audio.enable = lib.mkEnableOption "Enable audio configuration";
  config = lib.mkIf config.ari.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;

      # TODO: Revert when openblas-0.3.33 package is fixed
      alsa.support32Bit = false;
      pulse.enable = true;
      extraConfig.pipewire."98-crackling-fix".context.properties.default.clock = {
        quantum = 1024;
        min-quantum = 1024;
        max-quantum = 8192;
      };
    };
  };
}
