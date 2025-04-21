{
  # Core Wayland DE
  programs.hyprland.enable = true;

  # Audio setup
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # Wired-only networking
  services.systemd.network.enable = true;

  # Login (optional)
  services.getty.autoLogin.enable = true;
  services.getty.autoLogin.user = "yourUsername"; # Replace with your user

  # DBus & Portals (for notifications and some app compatibility)
  services.dbus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
}