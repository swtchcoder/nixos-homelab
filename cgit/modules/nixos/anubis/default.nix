{ root-domain, ... }:
{
  services.anubis = {
    instances = {
      main = {
        enable = true;
        settings = {
          TARGET = " ";
          REDIRECT_DOMAINS = root-domain;
          COOKIE_DOMAIN = root-domain;
        };
      };
    };
  };
}
