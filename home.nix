{ pkgs }: {
	programs.git = {
		enable = true;
		extraConfig = {
			credential.helper = "oauth";
		};
	};
}
