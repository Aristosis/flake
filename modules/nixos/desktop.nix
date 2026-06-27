{ config, lib, pkgs, ... }:
{
  options.ari.desktop.enable = lib.mkEnableOption "Install and configure desktop programs";

  config = lib.mkIf config.ari.desktop.enable {

    programs = {
      nix-ld.enable = true;

      niri.enable = true;
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      copyparty
      ffmpeg-full
      usbutils
      gparted
    ];

  };
}
