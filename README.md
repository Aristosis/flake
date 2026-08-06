# Ari's NixOS configuration flake

My working NixOS configuration that manages my:
- Work desktop (HP G3 285 MT BUSINESS PC)
- ~~Optiplex 380 home server~~
- ~~Acer laptop~~
- ~~Miscellaneous deployments~~

## Inputs
`nixpkgs` is nixos-unstable. I have some minor issues with it, particularly when rebuilding when
it complains about options I never used, like `displayManager.regreet is obsolete`.

`home-manager` for managing user-level packages and configurations.

`stylix` integrates with `home-manager` to automatically style everything. Mainly just for
consistency.

## Version control
Version control managed via [Jujutsu](https://www.jj-vcs.dev/latest/)!

