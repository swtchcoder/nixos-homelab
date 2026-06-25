{ root-domain, ... }:
let
  domain = "git.${root-domain}";
in
{
  services.nginx = {
    enable = true;
    virtualHosts.${domain} = {
      listen = [{ addr = "127.0.0.1"; port = 8000; }];
    };
  };
}
