{ config, ... }:
{
  nix = {
    sshServe = {
      enable = true;
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUYnAPuFC2bnrIHM8DiweTJThqZV9fjZMmI5Rx6bgw7 nix-ssh"
      ];
      protocol = "ssh";
      write = true;
    };
    settings.trusted-users = [ "nix-ssh" ];
  };
}
