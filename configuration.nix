# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  	imports = [
		./hardware-configuration.nix # Include the results of the hardware scan.
		./time_locale.nix
		./backups.nix
		./laptop.nix
		./user.nix
		./zsh.nix
		./ollama.nix
    	];
	
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	virtualisation.docker.enable = true;

	services.avahi = {
		enable = true;
		nssmdns = true;
		openFirewall = true;
	};

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};

	services.printing.drivers = [ pkgs.brlaser ];

  	# Enable flakes - glyphical
  	nix.settings.experimental-features = [ "nix-command" "flakes" ];	

	services.envfs.enable = true; # allows for typical bash shebang

 	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.initrd.luks.devices."luks-ba0201d2-0110-4ca8-ab1e-e6043e18aa0b".device = "/dev/disk/by-uuid/ba0201d2-0110-4ca8-ab1e-e6043e18aa0b";
 	networking.hostName = "nixos"; # Define your hostname.
 	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

 	# Enable networking
	networking.networkmanager.enable = true;

	networking.firewall = {
		enable = true;
	};

  	# Enable the X11 windowing system.
  	services.xserver = {
		enable = true;
		displayManager = {
			sddm.enable = true;	
		};
		desktopManager = {
			plasma5.enable = true;
		};
	};

  	# Configure keymap in X11
  	services.xserver = {
    		layout = "us";
    		xkbVariant = "";
  	};

  	# Enable CUPS to print documents.
  	services.printing.enable = true;

  	# Enable sound with pipewire.
  	sound.enable = true;
  	hardware.pulseaudio.enable = false;
  	security.rtkit.enable = true;
  	services.pipewire = {
    		enable = true;
    		alsa.enable = true;
    		alsa.support32Bit = true;
    		pulse.enable = true;
  	};

  	# Enable touchpad support (enabled default in most desktopManager).
  	# services.xserver.libinput.enable = true;

  	# List packages installed in system profile. To search, run:
  	# $ nix search wget
  	environment.systemPackages = with pkgs; [
		zsh
		zoxide
		git
		git-credential-oauth
		restic
		libnotify
		libsForQt5.bismuth
  		#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  		#  wget
  	];

  	# Some programs need SUID wrappers, can be configured further or are
  	# started in user sessions.
  	# programs.mtr.enable = true;
  	# programs.gnupg.agent = {
  	#   enable = true;
  	#   enableSSHSupport = true;
  	# };

  	# List services that you want to enable:

 	# Enable the OpenSSH daemon.
  	# services.openssh.enable = true;

  	# Open ports in the firewall.
  	# networking.firewall.allowedTCPPorts = [ ... ];
  	# networking.firewall.allowedUDPPorts = [ ... ];
  	# Or disable the firewall altogether.
  	# networking.firewall.enable = false;

  	# This value determines the NixOS release from which the default
  	# settings for stateful data, like file locations and database versions
  	# on your system were taken. It‘s perfectly fine and recommended to leave
  	# this value at the release version of the first install of this system.
  	# Before changing this value read the documentation for this option
  	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  	system.stateVersion = "23.11"; # Did you read the comment?

}
