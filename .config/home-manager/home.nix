{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "renn";
  home.homeDirectory = "/home/renn";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a shell provided by Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "nvim +Man!";
  };

  # Programs
  programs.home-manager.enable = true;
  home.shell.enableFishIntegration = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.fish = {
    enable = true;
    shellAbbrs = {
      ":q" = "exit";
      pacman = "sudo pacman";
      "!!" = "clear && exec fish";
    };
    functions = {
      "." = "nvim '+Oil $argv'";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      cheat = "curl cheat.sh/(string join + $argv) | bat";
      mkcd = "mkdir -p $argv && cd $argv";
    };
  };
  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.vicinae.enable = true;
  # programs.kitty.enable = true;
}
