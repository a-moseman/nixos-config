sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 14d
nix store gc
