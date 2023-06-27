{
  imports = [
    #../common/optional/ephemeral-btrfs.nix
    #../common/optional/encrypted-root.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "kvm-intel" ];
      luks.devices = {
        root = {
          # Use https://nixos.wiki/wiki/Full_Disk_Encryption
          device = "/dev/disk/by-uuid/cc2405fa-3f7b-4647-83df-ae01937d1eef";
          preLVM = true;
        };
      };
    };
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B7A3-51C0";
      fsType = "vfat";
    };

######
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/aea3704f-d4b9-4dc6-9375-c392ffade274";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" "space_cache=v2" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/aea3704f-d4b9-4dc6-9375-c392ffade274";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" "space_cache=v2" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/aea3704f-d4b9-4dc6-9375-c392ffade274";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" "space_cache=v2" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/aea3704f-d4b9-4dc6-9375-c392ffade274";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" "space_cache=v2" ];
      neededForBoot = true;
    };
######

  swapDevices =
    [ { device = "/dev/disk/by-uuid/9c6c69eb-9678-4225-86fa-5165dc171e92"; }
    ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
