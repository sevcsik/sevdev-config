{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "rn1.sevdev.hu"; # Define your hostname.
  networking.hostId = "d2ffde28";

  services.openssh.enable = true;
  services.openssh.extraConfig = "Banner /etc/sshd/banner";

  users.extraUsers.sevcsik = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/sevcsik";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxoGdokGmPmsaCCqI7Pv+PWeYUgN4Wi3+uckaGoVTE4dzH6SFg9sXLbYxtPNsyPtr5nbF4jeLdYtphPAeWt6SeM85j6luKH2ZSxIrIFR+gfNv79KrQgUlfvSyk/odErjHr+SVOD0eZMZkxwJquHhCYg3MEgilAOb/dE+lB4vU3dm1r8x/8HmKwkBch+EkS0TC6hZuwAjTUhho1Ndo+Ti1I4h3IsxAd9pj6v5+guuOMl661C9icHTprR1T/q5f+mVc5p4LzN4+Gl4WpoEWq/KnrF1POLrWU5Rws6ndWxKh/gD8auErfhYrqbkcMoxJlkpaTXmEx+kABJyfqpG6/Mi4x (none)" ]; 
  };

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "rn1.sevdev.hu" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          root = "/var/www/sevdev.hu";
        };
      };
    };
  };

}
