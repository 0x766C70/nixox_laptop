{ config, pkgs, ... }:

{
  home.username = "vlp";
  home.homeDirectory = "/home/vlp";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
  gimp
  exiftool
  nextcloud-client
  element-desktop
  whatsapp-for-linux
  libreoffice
  gajim
  copyq
  discord
  ];
  
  programs.git = {
    enable = true;
    userName = "vlp";
    userEmail = "vlp@fdn.fr";
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';

    shellAliases = {
      fr = "sudo nixos-rebuild switch --flake .#vlaptop";
      webcam_off = "sudo rmmod -f uvcvideo";
      webcam_on = "sudo modprobe uvcvideo";
    };
  };

  # SSH config symlink
  home.file.".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nextcloud/Documents/it/ssh/config";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
