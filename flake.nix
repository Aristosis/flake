{
  description = "Ari's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hjem.url = "github:feel-co/hjem";
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
    in
    {
      legacyPackages.${system} = pkgs;
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
            inherit inputs baseVars;
          };
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          inputs.hjem.nixosModules.default
        ];
      };
    };
}
