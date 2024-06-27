{pkgs, config, ...}: 
{
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
  };
  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

    # Extra software packages to install
  environment.systemPackages = with pkgs; [
    wmctrl
    parted
    git
    git-lfs
    virt-manager
    xz
    firefox
  ];

  programs.git.enable = true;
  programs.git.lfs.enable = true;

  # Enable the Neovim and Zsh programs
  programs.neovim.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
