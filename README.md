# Ari's NixOS configuration flake

My working NixOS configuration that manages my:
- Optiplex 380 home server
- Acer laptop
- Work desktop (HP G3 285 MT BUSINESS PC)
- ~~Miscellaneous deployments~~

Predominantly, inspiration was taken from the [Misterio77's starter configuration](https://github.com/Misterio77/nix-starter-configs).
A lot of the decisions are far from optimal in hindsight, but only from a code quality prespective.
A rewrite would just deepen the productivity sinkhole I get myself into when I touch this repo

> [!CAUTION]
> This NixOS configuration is made for my machines. Carelessly applying it to your computer may cause data loss if you don't generate your own hardware-configuration.nix.

## flake.nix - The entry point
### Inputs

```nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  home-manager.url = "github:nix-community/home-manager/release-26.05";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  stylix.url = "github:nix-community/stylix/release-26.05";
  stylix.inputs.nixpkgs.follows = "nixpkgs";
};
```
1. nixpkgs is pinned to release 26.05, I also have nixpkgs-unstable as an input for select packages I may want in the future.
2. [home-manager](https://github.com/nix-community/home-manager) is what I currently use to manage my user-space packages and configuration files.
3. [Stylix](https://github.com/nix-community/stylix) is a theming engine that lets me set one *base16* or *base24* colorscheme (or even generate one from an image
   and have it update my entire desktop to match. Phenominal, saves a lot of headaches.

### Outputs
```nix
outputs = {
  self,
  nixpkgs,
  home-manager,
  stylix,
  ...
} @ inputs: let
  system = "x86_64-linux";
in {
  packages.${system} = import ./pkgs nixpkgs.legacyPackages.${system};
  formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  overlays = import ./overlays {inherit inputs;};
  nixosModules = import ./modules/nixos;
  homeManagerModules = import ./modules/home-manager;
  ...
```

The first two lines create a "legacyPackages" attribute set that contains all my packages as NixOS expects in its usual channel-based format. I currenly only use
`x86_64-linux`, you can change it or add multiple.

"Overlays" are additions to the usual packages, plus any custom packages defined in `pkgs/default.nix`. The only one I have at the moment is the aforementioned *unstable* branch.

#### "Features"

`nixosModules` and `homeManagerModules` contain a bunch of modules, imported in `modules/nixos/default.nix` and `modules/home-manager/default.nix` respectively.
For example:

```nix
# modules/nixos/colemak.nix

{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.colemak.enable = lib.mkEnableOption "Enable colemak keyboard layout";

  config = lib.mkIf config.features.colemak.enable {
    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
  };
}
```

What this does should be self explanatory. I enable it in individual nixosConfigurations (i.e. machine-specific configurations). Simply importing the configurations would be simpler,
but would involve having to either declare a flake-level `path` value or using ugly relative paths `../../../../ew.nix`.

```nix
# hosts/nixos-desktop/configuration.nix

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

  features = {
    colemak.enable = true;
  };
}
```

> [!NOTE]
> I only add the modules required per `nixosConfiguration`. Case and point, I wouldn't want a theming engine or home-manager on my server, as you can see.

```nix
nixosConfigurations = {
  nixos-desktop = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ./hosts/nixos-desktop/configuration.nix
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
    ];
  };

  nixos-laptop = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ./hosts/nixos-laptop/configuration.nix
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
    ];
  };

  nixos-server = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ./hosts/nixos-server/configuration.nix
    ];
  };
};
```

