{
  imports = [
    ../common/optional/ephemeral-btrfs.nix
    ../common/optional/encrypted-root.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "kvm-intel" ];
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

  swapDevices =
    [ { device = "/dev/disk/by-uuid/bb5e6e21-9252-4d92-bd4a-9cfabaabd6ec"; }
    ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
