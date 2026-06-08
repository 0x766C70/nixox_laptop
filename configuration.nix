{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vlaptop"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Enable firewall for security
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  console.keyMap = "us-acentos";

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.vlp = {
    isNormalUser = true;
    description = "vlp";
    extraGroups = [ "networkmanager" "wheel" "inputs" ];
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Expose local custom packages into pkgs via an overlay
  nixpkgs.overlays = [
    (final: prev: {
      steamcontroller-udev-rules = final.callPackage ./pkgs/default.nix {};
    })
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.udev.packages = [ pkgs.gnome-settings-daemon pkgs.steamcontroller-udev-rules];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    # Desktop Extensions
    gnomeExtensions.appindicator

    # Development Tools
    python314
    git
    vim
    tmux
    tig

    # File Transfer & Management
    filezilla
    wget
    aria2
    sshfs

    # Document & PDF Tools
    pdfarranger
    ghostscript

    # Security & VPN
    openvpn
    pass
    gnupg
    pinentry-gnome3
    pam_u2f
    pamtester

    # Terminal Utilities
    neofetch
    nnn
    btop
    iotop
    iftop
    fzf
    eza
    glow
    cowsay
    dmidecode

    # Archive & Compression
    zip
    xz
    unzip
    p7zip
    zstd

    # Search & Text Processing
    ripgrep
    jq
    yq-go
    gnused
    gawk

    # Network Tools
    mtr
    iperf3
    dnsutils
    ldns
    socat
    nmap
    ipcalc
    ethtool
    gupnp-tools

    # System Monitoring & Debugging
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    pciutils
    usbutils
    nix-output-monitor

    # Basic System Utilities
    file
    which
    tree
    gnutar
    gamepad-tool
    joycond
    evtest
    SDL
    
    # Media
    vlc
    libvlc
    hugo
    libheif
    imagemagick

    # Printing
    cups-brother-hll2375dw
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  system.stateVersion = "24.11"; # Did you read the comment?

}
