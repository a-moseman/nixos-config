{ pkgs }: {
	programs.git = {
		enable = true;
		extraConfig = {
			credential.helper = "${
				pkgs.git.override {withLibsecret = true; }
			}/bin/git-credential-libsecret";
		};
	};
	environment.sessionVariables = {
		DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
	};
}
