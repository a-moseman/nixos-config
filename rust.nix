{ pkgs ? import <nixpkgs> {} }:
	pkgs.mkShell {
		nativeBuildInputs = with pkgs.buildPackages; [
				rustc
				cargo
			];
	RUST_BACKTRACE = 1;
	}
