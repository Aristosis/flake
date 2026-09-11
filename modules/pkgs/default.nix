{
  pkgs
}:
{
  fzf-wrapped = pkgs.callPackage ./fzf.nix { };
  bat-wrapped = pkgs.callPackage ./bat.nix { };
}
