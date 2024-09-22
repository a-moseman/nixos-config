{ config, pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	users.users.glyphical = {
                isNormalUser = true;
                description = "Glyphical";
                extraGroups = [ "networkmanager" "wheel" ];
                packages = (import ./user-packages.nix pkgs);
        };	
}
