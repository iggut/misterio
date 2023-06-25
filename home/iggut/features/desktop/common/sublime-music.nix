{ pkgs, lib, ... }: {
  home.packages = [ pkgs.sublime-music ];
  home.persistence = {
    "/persist/home/iggut".directories = [ ".config/sublime-music" ];
  };
}
