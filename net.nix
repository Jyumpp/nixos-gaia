{ config, pkgs, lib, ...}: 
{
  # Enable IP forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  }; 

  networking = {
   interfaces = {
      enp2s0.useDHCP = true;
      enp3s0.useDHCP = true;
    };
  };
}
