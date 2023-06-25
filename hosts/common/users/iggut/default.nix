{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.iggut = {
    password = "nixos";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "minecraft"
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];

    #openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/iggut/ssh.pub) ];
    #passwordFile = config.sops.secrets.iggut-password.path; #todo
    packages = [ pkgs.home-manager ];
  };

  #sops.secrets.iggut-password = { #todo
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

  home-manager.users.iggut = import ../../../../home/iggut/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
