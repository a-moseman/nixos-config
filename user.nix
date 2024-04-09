{ config, pkgs, ...}: {
	users.users.glyphical = {
		isNormalUser = true;
		description = "Glyphical";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			thunderbird
			firefox # just for sites that require HTML5, as librewolf does not support that
			librewolf
			kate
			zettlr
			zotero
			libreoffice
			jetbrains.idea-community
			discord
			tor
			tor-browser-bundle-bin
			hydrus
			wcalc
			python312
			dutree
			wireshark
			tmux
			gimp
			tomb
			pinentry
			pinentry-curses
			haruna
			nodejs
		];
	};
}
