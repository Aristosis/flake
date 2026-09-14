{
  description = "Ari's system configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      localPkgs = import ./packages { inherit pkgs; };
    in
    {
      packages.${system} = localPkgs;
      formatter.${system} = pkgs.nixfmt-tree;

      devShells.${system} = {
        default = pkgs.mkShellNoCC { packages = with pkgs; [ nil ]; };

        neovim = pkgs.mkShell {
          packages = with pkgs; [
            neovim
            stylua
            lua-language-server
          ];
        };
      };

      nixosConfigurations."nixos-desktop" = nixpkgs.lib.nixosSystem {
        specialArgs =
          let
            baseVars = import ./hosts/nixos-desktop/base-vars.nix;
          in
          {
            inherit inputs baseVars localPkgs;
          };
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          inputs.hjem.nixosModules.default
        ];
      };
    };
}
