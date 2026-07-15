{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.desktop.enable = lib.mkEnableOption "Install and configure desktop programs";

  config = lib.mkIf config.features.desktop.enable {
    # Display Manager - ly
    services.displayManager.ly.enable = true;

    # Audio
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

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        iosevka
        inter
        nerd-fonts.symbols-only
      ];
      fontconfig = {
        enable = true;
        subpixel.rgba = "rgb";
        hinting = {
          enable = true;
          style = "slight";
        };
      };
    };

    programs = {
      niri.enable = true;
      foot.enable = true;
      fish.enable = true;

      zsh = {
        enable = true;
        enableGlobalCompInit = false;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
      };
    };
  };
}
