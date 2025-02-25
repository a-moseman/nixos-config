sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
nix store gc
rm -rf .cache/*
rm ~/.bash_history
