{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel-pch
  '';

  networking.hostName = "nix";
  networking.networkmanager.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  qt.platformTheme = "qt5ct";
  time.timeZone = "Europe/Moscow";
  nixpkgs.config.pulseaudio = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  
  hardware.enableAllFirmware = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  };
  hardware.opentabletdriver.enable = true;
  hardware.opengl.enable = true;

  programs.bash.shellAliases = {
    config = "sudo nvim /etc/nixos/configuration.nix";
    switch = "sudo nixos-rebuild switch";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true;
  };

  services.xserver = {
    autorun = true;
    exportConfiguration = true;
    enable = true; 
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
    videoDrivers = [ "nvidia" ];
    displayManager = {
      startx.enable = true;
      autoLogin = {
        enable = true;
        user = "kostya";
      };
      defaultSession = "none+bspwm";
    };
    windowManager.bspwm = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.kostya = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    neofetch
    neovim
    bspwm
    sxhkd
    pciutils
    xorg.xorgserver
    xorg.xf86inputsynaptics
    xorg.xf86videointel
    xorg.xf86videoati
    xorg.xf86videonouveau
    xorg.xinit
    xorg.xev
    htop
    killall
    kitty
    brave
    alacritty
    discord
    flameshot
    pulseaudio
    pipewire
    git
    polybar
    rofi
    font-awesome
    scrot
    xclip
    telegram-desktop
    playerctl
    feh
    ffmpeg
    lttng-ust
    numactl
    osu-lazer
    mesa
    dotnet-sdk_7
    dotnet-runtime_7
    zip
    unzip
    rustup
    gcc
    vulkan-loader
    clang
    lld
    obsidian
    picom
    firefox
    rust-analyzer
    gromit-mpx
    nuget
    nodejs
    libreoffice
    ranger
    mpv
    obs-studio
    dolphin
    qt5ct
    nim2
    nimPackages.nimble
    python3
    pip
  ];

  system.stateVersion = "23.11"; 
}

