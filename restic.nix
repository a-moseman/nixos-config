{ config, pkgs, ... }: {
	services.restic.backups.nas = {
		enable = true;
		wantedBy = [ "glyphical.target" ];
		initialize = true;
		repositoryFile = "/home/glyphical/secrets/nas-repository";
		passwordFile = "/home/glyphical/secrets/restic-password";
		timerConfig = {
			OnCalendar = "daily";
			Persistent = true;
		};
		paths = [ "/home" ];
		exclude = [
			".thunderbird"
			"secrets"
			"nix-config"
			".cache"
		];
		extraOptions = [
			(builtins.readFile /home/glyphical/secrets/nas-extra-options)
		];
		pruneOpts = [
			"--keep-last 3"
		];
	};
	services.restic.backups.backblaze = {
		enable = true;
		wantedBy = [ "glyphical.target" ];
		initialize = true;
		repositoryFile = "/home/glyphical/secrets/backblaze-repository";
		environmentFile = "/home/glyphical/secrets/backblaze-environment";
		passwordFile = "/home/glyphical/secrets/restic-password";
		timerConfig = {
			OnCalendar = "weekly";
			Persistent = true;
		};
		paths = [ "/home" ];
		exclude = [
			".thunderbird"
			"secrets"
			"nix-config"
			".cache"
		];
		pruneOpts = [
			"--keep-last 3"
		];
	};
	users.users.restic = {
		isNormalUser = true;
	};
	security.wrappers.restic = {
		source = "${pkgs.restic.out}/bin/restic";
		owner = "restic";
		group = "users";
		permissions = "u=rwx,g=,o=";
		capabilities = "cap_dac_read_search=+ep";
	};

	systemd.services.restic-backups-nas.unitConfig.OnFailure = "notify-backup-failed.service";
	systemd.services.restic-backups-backblaze.unitConfig.OnFailure = "notify-backup-failed.service";

	systemd.services."notify-backup-failed" = {
		enable = true;
		description = "Notify on failed backup";
		serviceConfig = {
			Type = "oneshot";
			User = config.users.users.glyphical.name;
		};
		environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${
			toString config.users.users.glyphical.uid
			}/bus";
		script = ''
			${pkgs.libnotify}/bin/notify-send --urgency=critical \
			"Backup failed" \
			"$(journalctl -u restic-backups-nas -n 5 -o cat)"
		'';
	};

}
