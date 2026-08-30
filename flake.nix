{
  description = "Ari's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = import ./modules/pkgs.nix pkgs;
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ nil ];
    };

    nixosConfigurations."nixos-desktop" = nixpkgs.lib.nixosSystem {
      specialArgs =
      let
        baseVars = import ./hosts/nixos-desktop/base-vars.nix;
      in
      { inherit inputs baseVars; };
      modules = [./hosts/nixos-desktop/configuration.nix];
    };
  };
}
