# https://nixos.wiki/wiki/Module
{
  imports = [
    ./openssh
    ./cgit
    ./nginx
    ./anubis
    ./traefik
  ];
}
