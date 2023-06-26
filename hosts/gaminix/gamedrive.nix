{
  lib,
  config,
  ...
}: 
{
  # Windows game drive nvme
  fileSystems."/home/iggut/gamedisk" = {
    device = "/dev/disk/by-uuid/9E049FCD049FA735";
    fsType = "ntfs";
    options = ["uid=1000" "gid=1000" "nodev" "nofail" "x-gvfs-show" "rw" "user" "exec" "umask=000"];
  };
}
