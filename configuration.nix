# Confix for base Nix

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # System identity
  networking.hostName = "nixos";
  time.timeZone = "America/Chicago";

  # Networking
  networking = {
  interfaces.ens3 = {
    ipv4.addresses = [{
      address = "172.16.122.14";
      prefixLength = 24;
    }];
  };
  defaultGateway = {
    address = "172.16.122.1";
    interface = "ens3";
  };
  } 

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  


  # OpenSSH daemon
  services.openssh.enable = true;
  
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # User with sudo access
  users.users.luckysteve = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [  ];
  };

  # Wayland environment
  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Core system services
  services.dbus.enable = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Core environment
    hyprland wofi wezterm tmux ranger

    # UI / UX
    swww waybar mako

    # Clipboard
    cliphist wl-clipboard wtype

    # Audio
    pulsemixer pipewire wireplumber

    # Text Editor
    neovim

    # Power & lock
    batsignal waylock cage swayidle

    # Networking CLI
    iproute2

    # Utilities
    grim slurp btop git sway
  ];

  system.stateVersion = "24.11";
}
