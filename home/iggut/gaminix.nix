{ inputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/rgb
    ./features/productivity
    ./features/pass
    ./features/games
    ./features/music
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

  #  ------   --------   
  # | DP-1 | |HDMI-A-1| 
  #  ------   --------   
  monitors = [
    {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 165;
      noBar = true;
      x = 0;
      workspace = "2";
      enabled = false;
    }
    {
      name = "HDMI-A-1";
      width = 2560;
      height = 1440;
      refreshRate = 60;
      x = 1920;
      workspace = "1";
    }
  ];
}
