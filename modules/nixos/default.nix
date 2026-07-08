{
  audio = import ./audio.nix;
  bootloader = import ./bootloader.nix;
  colemak = import ./colemak.nix;
  desktop = import ./desktop.nix;
  displayManager = import ./display-manager.nix;
  graphicsDrivers = import ./graphics-drivers.nix;
  networking = import ./networking.nix;
  sshRemote = import ./remote-ssh.nix;
  fonts = import ./fonts.nix;
  tlp = import ./tlp.nix;
}
