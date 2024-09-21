{ pkgs, ... }: {
	programs.git = {
		enable = true;
		extraConfig = {
			credential.helper = "oauth";
		};
	};
	programs.zoxide = {
		enable = true;
		options = [
			"--cmd z"
		];
	};
}
