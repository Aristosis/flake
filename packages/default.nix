{
  pkgs
}:
{
  fzf-wrapped = pkgs.callPackage ./fzf.nix { };
  kitty-wrapped = pkgs.callPackage ./kitty { };
  bat-wrapped = pkgs.callPackage ./bat.nix { };
  fuzzel-wrapped = pkgs.callPackage ./fuzzel { };
  gamering = pkgs.callPackage ./umu-launcher-wrapped.nix { };
}
