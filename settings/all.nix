{ config, pkgs, ... }: {
	imports = [
		./laptop.nix
		./time_locale.nix
	];
}
