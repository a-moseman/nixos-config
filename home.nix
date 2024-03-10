{ pkgs }: {
	programs.git = {
		enable = true;
		extraConfig = {
			credential.helper = "${
				pkgs.git.override { withLibsecret = true; }
			}/bin/git-credential-libsecret";
			push = { autoSetupRemove = true; };
		};
	};
}
