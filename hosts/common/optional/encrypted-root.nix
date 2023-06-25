{ config, ... }:
  {
  boot.initrd.luks.devices = {
      root = {
        # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/ba31ed49-9e7b-462f-8690-bc48f1f5c21d";
        preLVM = true;
      };
  };
 }
