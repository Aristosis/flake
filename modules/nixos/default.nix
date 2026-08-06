{
  colemak = import ./colemak.nix;
  desktop = import ./desktop.nix;
  graphicsDrivers = import ./graphics-drivers.nix;
  sshRemote = import ./remote-ssh.nix;
  copyparty = import ./copyparty.nix;
  tlp = import ./tlp.nix;
  zram = import ./zram.nix;
}
