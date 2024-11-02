{ config, pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	users.users.glyphical = {
                isNormalUser = true;
                description = "Glyphical";
                extraGroups = [ "networkmanager" "wheel" "scanner" "lp" ];
                packages = (import ./packages/user/all.nix pkgs);
        };	
}
