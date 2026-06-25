{ root-domain, ... }:
let
  domain = "git.${root-domain}";
in
{
  services.cgit.main = {
    enable = true;
    nginx.virtualHost = domain;
    scanPath = "/srv/cgit";
    settings = {
      enable-commit-graph = true;
    };
    gitHttpBackend = {
      enable = true;
      checkExportOkFiles = false;
    };
  };
}
