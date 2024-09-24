pkgs: with pkgs;
		(import ./dev.nix pkgs) ++
		(import ./writting.nix pkgs) ++
		(import ./browser.nix pkgs) ++
		(import ./sec.nix pkgs) ++
		(import ./communication.nix pkgs) ++
		[
		hydrus
		wcalc
		dutree
		gimp
		haruna
		nudoku
		taskwarrior
		openshot-qt
		processing
		milkytracker
		lmms
		klavaro
		superTuxKart
		paleta
]
