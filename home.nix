{ pkgs }: {
	programs.git = {
		enable = true;
		extraConfig = {
			credential.helper = "oauth";
		};
	};
	
	programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestion.enable = true;
	  syntaxHighlighting.enable = true;
	
	  shellAliases = {
	    ll = "ls -l";
	    update = "sudo nixos-rebuild switch";
	  };
	  history = {
	    size = 10000;
	    path = "${config.xdg.dataHome}/zsh/history";
	  };
	
	};
}
