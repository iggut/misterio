{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/iggut

    ../common/optional/gamemode.nix
    ../common/optional/ckb-next.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/lol-acfix.nix
    ../common/optional/starcitizen-fixes.nix
  ];

  # TODO: theme "greeter" user GTK instead of using iggut to login
  services.greetd.settings.default_session.user = "iggut";

  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    printing.enable = true;
    printing.drivers = [
      #pkgs.cnijfilter2
      #pkgs.cnijfilter_4_00
      pkgs.gutenprint
      pkgs.gutenprintBin
    ];
  };

  networking = {
    hostName = "gaminix";
    useDHCP = true;
    interfaces.enp7s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;

      ipv4 = {
        addresses = [{
          address = "192.168.2.10";
          prefixLength = 24;
        }];
      };
      ipv6 = {
        addresses = [{
          address = "fe80::fec0:ad24:ee3b:2676";
          prefixLength = 64;
        }];
      };
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "iggut" "root" ];
    partition-manager.enable = true;
    xfconf.enable = true;
    nm-applet.enable = true; # Network manager tray icon 
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ amdvlk ];
      driSupport = true;
      driSupport32Bit = true;
    };
    openrgb.enable = true;
    opentabletdriver.enable = true;
  };

  system.stateVersion = "23.05";
}
