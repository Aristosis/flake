{
  inputs,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-desktop";

  imports =
  let
    modules = "${inputs.self}/modules/";
  in
    [
      ../default.nix
      ./hardware-configuration.nix

      (modules + "audio.nix")
      (modules + "colemak.nix")
      (modules + "copyparty.nix")
      (modules + "desktop.nix")
      (modules + "nvidia-drivers.nix")
      (modules + "remote-ssh.nix")
      (modules + "theme.nix")
      (modules + "zram.nix")

      (modules + "programs")
    ];

  users.defaultUserShell = pkgs.zsh;
  users.users.ari = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "26.05";
}
