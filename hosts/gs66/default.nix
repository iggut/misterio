{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/iggut

    ../common/optional/gamemode.nix
    ../common/optional/wireless.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/lol-acfix.nix
  ];

  # TODO: theme "greeter" user GTK instead of using iggut to login
  services.greetd.settings.default_session.user = "iggut";

  networking = {
    networkmanager.enable = true;
    hostName = "gs66";
    useDHCP = true;
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
    _1password-gui.polkitPolicyOwners = [ "iggut" "root" ];
    partition-manager.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  hardware = {
    nvidia = {
      prime.offload.enable = true;
      prime.intelBusId = "PCI:0:2:0";
      prime.nvidiaBusId = "PCI:1:0:0";
      modesetting.enable = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "23.05";
}
