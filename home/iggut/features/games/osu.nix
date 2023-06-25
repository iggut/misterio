{ pkgs, lib, ... }: {
  home.packages = [ pkgs.osu-lazer ];

  home.persistence = {
    "/persist/home/iggut".directories = [ ".local/share/osu" ];
  };
}
