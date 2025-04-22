# hosts/hyprland-box/hardware-configuration.nix

{ config, lib, pkgs, ... }:

{
  # Enable support for UEFI booting
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; # or kvm-amd for AMD CPUs
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/"; # Replace with actual UUID
    fsType = "ext4";
  };

  # Use systemd-boot with EFI
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # Set CPU microcode (Intel or AMD)
  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault true;
}
