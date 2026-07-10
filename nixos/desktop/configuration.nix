{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-desktop";

  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (builtins.attrValues inputs.self.nixosModules);

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
  };

  nix = {
    channel.enable = false;
    settings.experimental-features = "nix-command flakes";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    ari = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_MONETARY = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
  };

  ari = {
    audio.enable = true;
    desktop.enable = true;
    bootloader.enable = true;
    displayManager.enable = true;
    colemak.enable = true;
    sshRemote.enable = true;
    networking.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = true;
    };
    fonts.enable = true;
  };

  system.stateVersion = "26.05";
}
