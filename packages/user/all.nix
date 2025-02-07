pkgs: with pkgs;
		(import ./dev.nix pkgs) ++
		(import ./writing.nix pkgs) ++
		(import ./browser.nix pkgs) ++
		(import ./sec.nix pkgs) ++
		(import ./communication.nix pkgs) ++
		[
		wcalc
		dutree
		gimp
		haruna
		nudoku
		taskwarrior
		openshot-qt
		klavaro
		superTuxKart
		paleta
		yt-dlp
		qgis-ltr
		qemu
		wget
		sshpass
		dexed
]
