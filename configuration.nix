# hosts/hyprland-box/configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # System identity
  networking.hostName = "hyprland-box";
  time.timeZone = "America/Chicago";

  # Bootloader
  boot.loader.grub.enable = true;

  # OpenSSH daemon
  services.openssh.enable = true;
  
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # User with sudo access
  users.users.luckysteve = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ ];
  };

  # Enable autologin to TTY1
  services.getty.autoLogin.enable = true;
  services.getty.autoLogin.user = "luckysteve";

  # Wayland environment
  programs.hyprland.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Core system services
  services.systemd.network.enable = true;
  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  # Sound with PipeWire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome
    jetbrains-mono
  ];

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

    # Power & lock
    batsignal waylock cage swayidle

    # Networking CLI
    iproute2

    # Utilities
    grim slurp btop git sway
  ];

  system.stateVersion = "23.11";
}
