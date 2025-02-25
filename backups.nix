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
		};
		environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${
			toString config.users.users.glyphical.uid
			}/bus";
		script = ''
			${pkgs.libnotify}/bin/notify-send --urgency=critical "Backup failed"
		'';
	};

	services.restic.backups.nas = {
		initialize = true;
		repositoryFile = "/home/glyphical/Secrets/nas-repository";
		passwordFile = "/home/glyphical/Secrets/restic-password";
		timerConfig = {
			OnCalendar = "daily";
			Persistent = true;
		};
		paths = [ "/home" ];
		exclude = [
			".thunderbird"
			"Secrets"
			"nixos-config"
			".cache"
			".ssh"
			".bash_history"
		];
		extraOptions = [
			"sftp.command='ssh -i /home/glyphical/Secrets/restic-nas-ssh-keys -o StrictHostKeyChecking=no amoseman@10.0.0.33 -s sftp'"
		];
		pruneOpts = [
			"--keep-last 3"
		];
	};
	services.restic.backups.backblaze = {
		initialize = true;
		repositoryFile = "/home/glyphical/Secrets/backblaze-repository";
		environmentFile = "/home/glyphical/Secrets/backblaze-environment";
		passwordFile = "/home/glyphical/Secrets/restic-password";
		timerConfig = {
			OnCalendar = "weekly";
			Persistent = true;
		};
		paths = [ "/home" ];
		exclude = [
			".thunderbird"
			"Secrets"
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
