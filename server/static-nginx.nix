{ config, pkgs, ... }:

{
	networking.firewall.allowedTCPPorts = [ 80 443 ];

	services.nginx = {
		enable = true;
		virtualHosts = {
			"sevdev.hu" = {
				forceSSL = true;
				enableACME = true;
				locations."/" = {
					root = "/var/www/sevdev.hu";
				};

				# To not break old IPFS URLs
				extraConfig = "location ~ \"/ipns/sevdev\\.hu(.*)$\" {"
				            + "  return 301 $scheme://$host$1;"
				            + "}";

			};
			
			"www.sevdev.hu" = {
				forceSSL = true;
				enableACME = true;

				locations."/" = {
					extraConfig = "return 301 $scheme://sevdev.hu$1;";
				};
			};
		};
	};
}
