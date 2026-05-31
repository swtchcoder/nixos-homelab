{
  fileSystems."/nix".neededForBoot = true;
  
  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/sda";

    content.type = "gpt";

    content.partitions.boot = {
      size = "1M";
      type = "EF02";
    };

    content.partitions.esp = {
      size = "128M";
      type = "EF00";
    
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };
    
    content.partitions.root = {
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = [ "-f" ];
        
        subvolumes = {
          "/persistent" = {
            mountOptions = [ "subvol=persist" "noatime" ];
            mountpoint = "/persistent";
          };

          "/nix" = {
            mountOptions = [ "subvol=nix" "noatime" ];
            mountpoint = "/nix";
          };
        };
      };
    };
  };
}
