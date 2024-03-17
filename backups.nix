{ config, pkgs, ... }: {
	security.wrappers.restic = {
		source = "${pkgs.restic.out}/bin/restic";
		owner = "restic";
		group = "users";
		permissions = "u=rwx,g=,o=";
		capabilities = "cap_dac_read_search=+ep";
	};
	users.users.restic = {
		isNormalUser = true;
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

	services.restic.backups.nas = {
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
			"nixos-config"
			".cache"
			".ssh"
			".bash_history"
		];
		extraOptions = [
			"sftp.command='ssh -i /home/glyphical/secrets/restic-nas-ssh-keys -o StrictHostKeyChecking=no amoseman@10.0.0.33 -s sftp'"
		];
		pruneOpts = [
			"--keep-last 3"
		];
	};
	services.restic.backups.backblaze = {
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
			"nixos-config"
			".cache"
			".ssh"
			".bash_history"
		];
		pruneOpts = [
			"--keep-last 3"
		];
	};
}
