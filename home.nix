{ pkgs }: {
	programs.git = {
		enable = true;
		userName = "a-moseman";
		userEmail = "drewmoseman@gmail.com"
		extraConfig = {
			credential.helper = "${
				pkgs.git.override { withLibsecret = true; }
			}/bin/git-credential-libsecret";
		};
	};
}
