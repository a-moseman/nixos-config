{ config, pkgs, ...}: {
	users.users.glyphical = {
		isNormalUser = true;
		description = "Glyphical";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			thunderbird
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
			kleopatra
			nudoku
			plantuml
			zulu17
			sqlite
			taskwarrior
			openshot-qt
			xca
		];
	};
}
