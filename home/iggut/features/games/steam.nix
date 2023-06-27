{ pkgs, config, lib, ... }:
let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
in
{
  home.packages = with pkgs; [
    steam-with-pkgs
    gamescope
    mangohud
    protonup-qt 
    protontricks
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam-with-pkgs;
    gamescopeSession.enable = true;
  };

  programs.mangohud = {
    enable = true;
    # Mangohud config
    settings = {
      arch = true;
      background_alpha = "0.05";
      cpu_color = "FFFFFF";
      cpu_temp = true;
      engine_version = true;
      engine_color = "FFFFFF";
      font_size = 20;
      fps = true;
      fps_limit = "120+60+0";
      frame_timing = 0;
      gamemode = true;
      gl_vsync = 0;
      gpu_color = "FFFFFF";
      gpu_temp = true;
      no_small_font = true;
      offset_x = 50;
      position = "top-right";
      round_corners = 8;
      vram = true;
      vulkan_driver = true;
      toggle_fps_limit = "Ctrl_L+Shift_L+F1";
      vsync = 1;
    };
  };

  #Enable Gamescope
  #programs.gamescope = {
    #enable = true;
    #package = pkgs.gamescope_git;
    #capSysNice = true;
    #args = ["--prefer-vk-device 10de:1f15"];
    #env = {
    #  "DRI_PRIME" = "1";
    #  "__NV_PRIME_RENDER_OFFLOAD" = "1";
    #  "__VK_LAYER_NV_optimus" = "NVIDIA_only";
    #  "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    #  "MESA_VK_DEVICE_SELECT" = "pci:10de:1f15";
    #};
  #};

  #home.persistence = {
  #  "/persist/home/iggut" = {
  #    allowOther = true;
  #    directories = [
  #      ".factorio"
  #      ".config/Hero_Siege"
  #      ".config/unity3d/Berserk Games/Tabletop Simulator"
  #      ".config/unity3d/IronGate/Valheim"
  #      ".local/share/Tabletop Simulator"
  #      ".local/share/Paradox Interactive"
  #      ".paradoxlauncher"
  #      {
  #        # A couple of games don't play well with bindfs
  #        directory = ".local/share/Steam";
  #        method = "symlink";
  #      }
  #    ];
  #  };
  #};
}
