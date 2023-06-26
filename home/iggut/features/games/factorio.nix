{ lib, pkgs, ... }: {
  home = {
    packages = [ pkgs.factorio ];
    #persistence = {
    #  "/persist/home/iggut" = {
    #    allowOther = true;
    #    directories = [ ".factorio" ];
    #  };
    #};
  };
}
