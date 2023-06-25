{ pkgs, lib, ... }: {
  home.packages = [ pkgs.prismlauncher-qt5 ];

  home.persistence = {
    "/persist/home/iggut".directories = [ ".local/share/PrismLauncher" ];
  };
}
