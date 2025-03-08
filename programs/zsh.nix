{ config, pkgs, ...}: {
        programs.zsh = {
                enable = true;
                enableCompletion = true;
                syntaxHighlighting.enable = true;

                ohMyZsh = {
                        enable = true;
                        theme = "gnzh";
                };
        };
}
