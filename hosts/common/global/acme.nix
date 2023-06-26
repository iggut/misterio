{ lib, ... }:
{
  # Enable acme for usage with nginx vhosts
  security.acme = {
    defaults.email = "igor.gutchin@gmail.com";
    acceptTerms = true;
  };

  #environment.persistence = {
  #  "/persist" = {
  #    directories = [
  #      "/var/lib/acme"
  #    ];
  #  };
  #};
}
