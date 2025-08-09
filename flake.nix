{
  description = "glyphical's NixOS flake";

  inputs = {
	#nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";	
	nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
  };

  outputs = { self, nixpkgs }@inputs: {
	nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			./configuration.nix
		];
	};
	imports = [ ./home.nix ];
  };
}
