{ config,  pkgs, ... }: {
		imports = [ <nixos/home-manager> ];

		home-manager.users.glyphical = {
			programs.git = {
				enable = true;
				extraConfig = {
					credential-helper = "oauth";
				};
			};
			programs.zoxide = {
				enable = true;
			};

			home.stateVersion = "24.05";
		};
	}
