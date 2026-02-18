# NixOS Laptop Configuration

> *"Your configuration is now reproducible, declarative, and dare I say... elegant."* — botbot

A complete NixOS laptop configuration using Flakes and Home Manager. This setup provides a modern GNOME desktop environment with a carefully curated set of development tools, utilities, and security features.

## 🎯 Overview

This repository contains a fully declarative NixOS configuration for a laptop system (`vlaptop`), featuring:

- **NixOS 24.11** - Stable, reproducible system configuration
- **Home Manager** - Declarative user environment management
- **Flakes** - Modern, hermetic Nix configuration approach
- **GNOME Desktop** - Clean, user-friendly desktop environment
- **Security-focused** - Firewall enabled, GPG agent with SSH support

## 📁 Repository Structure

```
.
├── flake.nix                 # Flake entry point and system definition
├── flake.lock                # Locked dependencies for reproducibility
├── configuration.nix         # System-wide configuration
├── home.nix                  # User-specific configuration (home-manager)
├── hardware-configuration.nix # Hardware-specific settings (auto-generated)
└── REVIEW.md                 # Comprehensive configuration review guide
```

## 🚀 Quick Start

### Prerequisites

- A working NixOS installation (or bootable NixOS media)
- Git installed
- Flakes enabled (automatically configured by this setup)

### Installation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/0x766C70/nixox_laptop.git
   cd nixox_laptop
   ```

2. **Update hardware configuration** (if installing on a new machine):
   ```bash
   sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

3. **Customize for your system:**
   - Edit `configuration.nix`: Update hostname, timezone, locale
   - Edit `home.nix`: Update username, email, and user-specific settings
   - Edit `flake.nix`: Update the hostname in `nixosConfigurations` if needed

4. **Apply the configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#vlaptop
   ```

   Or use the convenient alias (after first successful build):
   ```bash
   fr  # Shorthand for flake rebuild
   ```

## 🛠️ System Configuration

### Core System Features

- **Bootloader:** systemd-boot with EFI support
- **Display Manager:** GDM (GNOME Display Manager)
- **Desktop Environment:** GNOME
- **Network Management:** NetworkManager
- **Audio:** PipeWire (with ALSA and PulseAudio compatibility)
- **Keyboard Layout:** US International
- **Timezone:** Europe/Paris
- **Locale:** English (US) with French regional settings

### Security Features

- ✅ Firewall enabled by default
- ✅ GPG agent with SSH support
- ✅ Secure boot compatible (systemd-boot)
- ✅ No auto-login (security best practice)
- 🔐 Password management with `pass`
- 🔐 VPN support (OpenVPN)
- 🔐 Tailscale for secure networking

### Installed Packages

The configuration includes a comprehensive set of packages organized by category:

#### Development Tools
- Python 3.14, Git, Vim, Tmux, Tig

#### File Management & Transfer
- FileZilla, wget, aria2, sshfs

#### Document Tools
- LibreOffice, PDF Arranger, Ghostscript

#### Security & VPN
- OpenVPN, pass, GnuPG, pinentry-gnome3

#### Terminal Utilities
- neofetch, nnn, btop, iotop, iftop, fzf, eza, glow

#### Network Tools
- mtr, iperf3, dnsutils, nmap, ipcalc, ethtool

#### System Monitoring
- strace, ltrace, lsof, sysstat, lm_sensors, nix-output-monitor

#### Multimedia
- VLC, GIMP, Element Desktop, Discord

#### Productivity
- Nextcloud Client, CopyQ (clipboard manager)

## 🏠 Home Manager Configuration

User-specific configuration is managed through Home Manager:

### User Applications
- **Terminal:** Alacritty with custom font and scrolling settings
- **Shell Prompt:** Starship with minimal, clean configuration
- **Editor:** Git configured with user details
- **Office Suite:** LibreOffice
- **Communication:** Element Desktop, Discord

### Shell Configuration

The bash configuration includes:
- Starship prompt integration
- GPG agent for SSH authentication
- Custom aliases:
  - `fr` - Quick flake rebuild
  - `webcam_off` / `webcam_on` - Webcam control

### SSH Configuration

SSH config is managed via a symlink to a Nextcloud-synced directory, keeping sensitive connection details out of version control while maintaining portability.

#### GPG as SSH Key

This configuration uses GPG keys for SSH authentication. To set this up:

1. **Find your GPG keygrip:**
   ```bash
   gpg --list-keys --with-keygrip
   ```

2. **Add the keygrip to `sshcontrol`:** The keygrip (not the key ID!) is automatically configured in `~/.gnupg/sshcontrol` via Home Manager.

3. **Verify the setup:**
   ```bash
   # Check that GPG agent is running with SSH support
   echo $SSH_AUTH_SOCK
   # Should output something like: /run/user/1000/gnupg/d.xxx/S.gpg-agent.ssh
   
   # List available SSH keys
   ssh-add -L
   # Should display your public key
   ```

4. **Troubleshooting:**
   - If `ssh-add -L` shows nothing, restart GPG agent: `gpgconf --kill gpg-agent`
   - Make sure the keygrip in `home.nix` matches your actual GPG key
   - Check GPG agent logs: `journalctl --user -u gpg-agent -n 50`

## 🔄 Maintenance

### Updating the System

```bash
# Update flake inputs
nix flake update

# Rebuild system with new inputs
sudo nixos-rebuild switch --flake .#vlaptop
```

### Garbage Collection

```bash
# Remove old generations and clean up
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

### Listing Generations

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Rolling Back

```bash
# Rollback to previous generation
sudo nixos-rebuild switch --rollback
```

## 🎨 Customization

### Adding Packages

**System-wide packages** (edit `configuration.nix`):
```nix
environment.systemPackages = with pkgs; [
  # Add your package here
  yourPackage
];
```

**User packages** (edit `home.nix`):
```nix
home.packages = with pkgs; [
  # Add your package here
  yourPackage
];
```

### Enabling Services

Edit `configuration.nix` to enable system services:
```nix
services.yourService = {
  enable = true;
  # Additional configuration
};
```

## 🔍 Troubleshooting

### Build Errors

If you encounter build errors:
1. Check syntax with `nix flake check`
2. Validate individual files with `nix-instantiate --parse <file>.nix`
3. Review the error message carefully—Nix errors are precise

### Network Issues

If network isn't working after installation:
```bash
sudo systemctl restart NetworkManager
```

### Audio Not Working

Ensure PipeWire services are running:
```bash
systemctl --user status pipewire pipewire-pulse
```

## 📚 Additional Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [NixOS Wiki](https://nixos.wiki/)
- [Nix Package Search](https://search.nixos.org/)

## 🤝 Contributing

Found an issue or want to suggest an improvement? Open an issue or submit a pull request!

## 📝 License

This configuration is provided as-is. Feel free to use and modify it for your own needs.

---

*"Remember: NixOS is like a puzzle, and you're the genius solving it."* — botbot
