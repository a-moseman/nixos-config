{ config,  pkgs, ... }: {
		imports = [ <nixos/home-manager> ];

		home-manager.users.glyphical = {
			imports = [ ./user-packages.nix ];
			programs.git = {
				enable = true;
				extraConfig = {
					credential-helper = "oauth";
				};
			};
			programs.zsh ={
				enable = true;
				enableCompletion = true;
				syntaxHighlighting.enable = true;
		
				oh-my-zsh = {
					enable = true;
					theme = "agnoster";
				};
			};
			programs.zoxide = {
				enable = true;
			};

			home.stateVersion = "24.05";
		};
	}
