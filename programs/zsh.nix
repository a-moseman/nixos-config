{ config, pkgs, ...}: {
        programs.zsh = {
                enable = true;
                enableCompletion = true;
                syntaxHighlighting.enable = true;

                oh-my-zsh = {
                        enable = true;
                        theme = "agnoster";
                };
        };
}
