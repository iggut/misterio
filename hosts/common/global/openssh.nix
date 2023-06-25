{ outputs, lib, config, ... }:

let
  inherit (config.networking) hostName;
  hosts = outputs.nixosConfigurations;
  #pubKey = host: ../../${host}/ssh_host_ed25519_key.pub; #too
  #gitHost = hosts."alcyone".config.networking.hostName;

  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  hasOptinPersistence = config.environment.persistence ? "/persist";
in
{
  services.openssh = { #todo
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = true;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };

    #hostKeys = [{
    #  path = "${lib.optionalString hasOptinPersistence "/persist"}/etc/ssh/ssh_host_ed25519_key";
    #  type = "ed25519";
    #}];
  };

  # Passwordless sudo when SSH'ing with keys #todo
  #security.pam.enableSSHAgentAuth = true;
}
