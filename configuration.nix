{ config, pkgs, ... }: {
  	imports = [
		./hardware-configuration.nix # Include the results of the hardware scan.
		./backups.nix
		./user.nix
		./settings/all.nix
		./programs/all.nix
    	];
	

	environment.etc."myscripts/mem.sh" = {
		mode = "0555";
		text = ''
			#!/usr/bin/env bash
			path="/etc/myscripts/BrainPlus-1.0-SNAPSHOT.jar"
			java -jar $path $(pwd) "$@"
		'';
	};
	environment.shellAliases = {
		mem = "sh /etc/myscripts/mem.sh";
	};

	# enable GPU
	hardware.graphics.enable = true;
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.nvidia.open = true;
	hardware.nvidia.prime = { # required for hybrid graphics (integrated and dedicated GPU)
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
		# following is command to find bus IDs
		# nix shell nixpkgs#pciutils -c lspci -d ::03xx
	};
	hardware.nvidia.modesetting.enable = true;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	
	hardware.sane.enable = true;
	hardware.sane.extraBackends = [ pkgs.sane-airscan pkgs.epkowa ];
	services.ipp-usb.enable = true;


	virtualisation.docker.enable = true;

	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;
	
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};

	services.printing.drivers = [ pkgs.epson-escpr ];

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

	#boot.kernelParams = ["nvidia_drm.modeset=1"]; # for GPU
	#hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable; # for GPU
	#hardware.opengl.enable = true; # for GPU

  	# Configure keymap in X11
  	services.xserver = {
    		xkb.layout = "us";
    		xkb.variant = "";
  	};

  	# Enable CUPS to print documents.
  	services.printing.enable = true;

  	# Enable sound with pipewire.
  	# sound.enable = true;
  	# hardware.pulseaudio.enable = false;
  	# security.rtkit.enable = true;
  	 services.pipewire = {
    	 	enable = true;
    	 	alsa.enable = true;
    	 	alsa.support32Bit = true;
    	 	pulse.enable = true;
		jack.enable = true;
  	};

	# low latency pipewire setup for ardour
	# from: https://nixos.wiki/wiki/PipeWire
  	services.pipewire.extraConfig.pipewire."92-low-latency" = {
   		"context.properties" = {
      			"default.clock.rate" = 48000;
      			"default.clock.quantum" = 2048;
      			"default.clock.min-quantum" = 2048;
      			"default.clock.max-quantum" = 8192;
    		};
  	};

  	# Enable touchpad support (enabled default in most desktopManager).
  	# services.xserver.libinput.enable = true;

  	# List packages installed in system profile. To search, run:
  	# $ nix search wget
  	environment.systemPackages = (import ./packages/system/all.nix pkgs);

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
