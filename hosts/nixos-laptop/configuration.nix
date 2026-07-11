{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-laptop";

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
    desktop.enable = true;
    colemak.enable = true;
    sshRemote.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = false;
    };
    tlp.enable = true;
  };

  system.stateVersion = "26.05";
}
