{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  systemd.services.sing-box = {
    description = "sing-box VPN";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c /home/ustkost/Downloads/config.json";
      Restart = "on-failure";
      User = "root";
    };
  };

  security.sudo.extraRules = [{
    users = [ "ustkost" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/systemctl start sing-box";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/run/current-system/sw/bin/systemctl stop sing-box";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.firewall.trustedInterfaces = [ "tun0" ];

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.enable = true;
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      disableWhileTyping = true;
    };
  };
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = true;
    extraCommands = ''
    polybar &
    setxkbmap -layout us,ru -option grp:alt_shift_toggle &
    '';
  };

  services.pulseaudio.enable = true;
  services.pipewire.enable = false;

  users.users.ustkost = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    fastfetch
    git
    alacritty
    sing-box
    dig
    dmenu
    (polybar.override {
      pulseSupport = true;
    })
    playerctl
    scrot
    xclip
    fzf
    pfetch
    go
    nodejs
    gcc
    kdePackages.dolphin
  ];

 system.copySystemConfiguration = true;
 system.stateVersion = "25.05"; # Did you read the comment?
}
