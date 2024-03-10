{ pkgs }: {
	programs.git = {
		enable = true;
		package = pkgs.gitFull;
		config.credential.helper = "libsecret";
	};
}
