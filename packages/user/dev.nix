pkgs: with pkgs; [
	jetbrains.idea-community
	tmux
	neovim
	#jdk21_headless
	jdk
	fontconfig
	processing
	jbang
	nodejs
	python312 # should just use shell.nix approach instead
	plantuml
	python312Packages.pip
	ghidra
	gcc
	gdb
	gnumake
	meson
	flamegraph
	python312Packages.ninja
	linuxPackages_latest.perf
]
