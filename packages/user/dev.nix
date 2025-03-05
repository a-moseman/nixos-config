pkgs: with pkgs; [
	jetbrains.idea-community
	tmux
	sqlite
	h2
	#jdk21_headless
	jdk
	fontconfig
	processing
	jbang
	nodejs
	python312 # should just use shell.nix approach instead
	plantuml
	godot_4
	docker
	minio
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
