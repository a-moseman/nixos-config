{ config, pkgs, ...}: {
	imports = [
		./ollama.nix
		./zsh.nix
	];
}
