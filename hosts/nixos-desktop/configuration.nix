{
  baseVars,
  inputs,
  pkgs,
  ...
}:
{
  networking.hostName = "nixos-desktop";

  imports =
  let
    modules = "${inputs.self}/modules/";
    users = "${modules}/users/";
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
      (modules + "niri.nix")
      (modules + "zram.nix")

      (users + "ari.nix")
    ];

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "26.05";
}
