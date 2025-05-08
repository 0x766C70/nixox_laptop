{ config, pkgs, ... }:

{
  home.username = "vlp";
  home.homeDirectory = "/home/vlp";

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
  vlc
  ];

  home.file.gpgSshKeys = {
    target = ".gnupg/sshcontrol";
    text = ''
      1E1B2ED3022B0BF84835E8A58A473AC7421E68FA 600
                                               '';
  }; 
  
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "vlp";
    userEmail = "vlp@fdn.fr";
  };

  # starship - an customizable prompt for any shell
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

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
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

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      fr = "sudo nixos-rebuild switch --flake /home/vlp/nixos_laptop";
      laptop = "ssh laptop.vlp.fdn.fr -p 8024";
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
