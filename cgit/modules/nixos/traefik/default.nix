{ config, root-domain, ... }:
let
  domain = "git.${root-domain}";
  anubis = config.services.anubis;
  anubis-url = "unix://${anubis.instances.main.settings.BIND}";
in
{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.traefik = {
    enable = true;
    dynamicConfigOptions.http = {
      middlewares.anubis.forwardAuth.address = "${anubis-url}";

      routers.cgit = {
        rule = "Host(`${domain}`)";
        service = "cgit";
        middlewares = [ "anubis" ];
      };

      services.cgit.loadbalancer.servers = [
        { url = "http://127.0.0.1:8000"; }
      ];
    };
  };
}
