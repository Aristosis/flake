{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ] ++ (builtins.attrValues inputs.self.nixosModules);

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    channel.enable = false;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    ari = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_MONETARY = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
  };
  
  networking.hostName = "nixos-laptop";

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
      nvidia.enable = false;
    };
    fonts.enable = true;
    tlp.enable = true;
  };

  system.stateVersion = "26.05";
}
