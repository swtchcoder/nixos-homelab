{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    preservation.url = "github:nix-community/preservation";
  };

  outputs = { self, nixpkgs, disko, preservation, ... } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {
          root-domain = "switchcodeur.com";
          inputs = inputs;
        };
        modules = [
          disko.nixosModules.disko
          preservation.nixosModules.preservation
          ./disko
          ./preservation
          ./nixos
          ./modules/nixos
        ];
      };
    };
  };
}
