{
  description = "Ari's system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in {

    packages.${system} = import ./modules/nixos/pkgs.nix pkgs;
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ nls ];
    };

    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
        ];
      };

      # TODO: Deal with the rest of the nixosConfigurations
      # nixos-laptop = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
      #     ./hosts/nixos-laptop/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     stylix.nixosModules.stylix
      #   ];
      # };
      #
      # nixos-server = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
      #     ./hosts/nixos-server/configuration.nix
      #   ];
      # };
    };
  };
}
