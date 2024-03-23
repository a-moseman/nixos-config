{ config, pkgs,  ... }: {
	config.services.postgresql = {
		enable = true;
		ensureDatabases = [ "database" ];
		enableTCPIP = true;
		authentication = pkgs.lib.mkOverride 10 ''
			#type database DBuser origin-address auth-method
			# ipv4
			host all all 127.0.0.1/32 trust
			# ipv6
			host all all ::1/128 trust
		'';
		initialScript = pkgs.writeText "backend-initScript" ''
			CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
			CREATE DATABASE nixcloud;
			GRANT ALL PRIVILEGES ON DATABSE nixcloud TO nixcloud;	
		''
	};
}
