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
      ../default.nix
    ]
    ++ (builtins.attrValues inputs.self.nixosModules);

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

  features = {
    # audio.enable = true;
    desktop.enable = true;
    # bootloader.enable = true;
    # displayManager.enable = true;
    colemak.enable = true;
    # sshRemote.enable = true;
    # networking.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = true;
    };
    # fonts.enable = true;
  };

  system.stateVersion = "26.05";
}
