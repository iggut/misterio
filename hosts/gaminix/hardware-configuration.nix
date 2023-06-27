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
          device = "/dev/disk/by-uuid/ba31ed49-9e7b-462f-8690-bc48f1f5c21d";
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
    { device = "/dev/disk/by-uuid/E1E4-8C67";
      fsType = "vfat";
    };

######
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c56097e9-54c1-491f-84b5-20e44bd762b7";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/c56097e9-54c1-491f-84b5-20e44bd762b7";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/c56097e9-54c1-491f-84b5-20e44bd762b7";
      fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" ];
      neededForBoot = true;
    };
######

  swapDevices =
    [ { device = "/dev/disk/by-uuid/bb5e6e21-9252-4d92-bd4a-9cfabaabd6ec"; }
    ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
