# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  nixos-btw = pkgs.writeShellScriptBin "nixos-btw" ''
    printf "test package\n"
    printf "I use\n"
    fastfetch
    printf "btw\n"
  '';
  # example = pkgs.callPackage ./example { };
}
