{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.iggut = {
    initialPassword = "nixos";
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
    packages = with pkgs; [ 
      bottles # Wine manager
      home-manager
      age-plugin-yubikey
      google-chrome # Hate it and love it Browser
      glxinfo
      polkit_gnome # Polkit manager
      android-tools # Tools for debugging android devices
      appimage-run # Appimage runner
      vlc # Video player
      neofetch # pc info
      mullvad-vpn # VPN Client
      nwg-drawer
      ntfs3g # Support NTFS drives
      sfwbar
      yubikey-manager
      yubikey-manager-qt
      yubioath-flutter
      yubico-pam
      yubikey-personalization
      wget
      gimp
      gnome.file-roller # Archive file manager
      gnome.gnome-calculator # Calculator
      gnome.gnome-disk-utility # Disks manager
      gnome.nautilus # File manager
      grim # Screenshot tool
      qbittorrent
      usbutils
      vulkan-tools
      wdisplays # Displays manager
      wlogout # Logout screen
      xdg-utils
    ];
  };

  #sops.secrets.iggut-password = { #todo
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

  home-manager.users.iggut = import ../../../../home/iggut/${config.networking.hostName}.nix;

  services.geoclue2.enable = true;
  services.dbus.enable = true;
  services.gvfs.enable = true; # Needed for nautilus
  security.polkit.enable = true; # Enable polkit security
  security.pam.services = { swaylock = { }; };
}
