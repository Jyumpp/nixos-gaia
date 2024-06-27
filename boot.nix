{ config, pkgs, lib, ... }:
{
  # Bootloader configuration for systemd-boot (UEFI systems)
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" "nvidia"];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.loader.systemd-boot.enable = true;
  
  # Boot silently
  boot.kernelParams = [ "quiet" "rd.systemd.show_status=false"]; # Ensure a quiet boot
  boot.consoleLogLevel = 0;

  # Set up locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Specify Nix specific options
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable SSH for remote access
  services.openssh.enable = true; services.openssh.settings.PasswordAuthentication = true;
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Nvidia setup
  hardware.opengl.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
