{
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      files = [
        { file = "/etc/machine-id"; inInitrd = true; }
      ];

      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/log"
        "/srv/cgit"
      ];
    };
  };

  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
