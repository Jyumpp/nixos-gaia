{config, lib, pkgs,  ...}:

let
  kioskAdminHunterSSHKeys = builtins.fetchurl {
    url = "https://github.com/jyumpp.keys";
    sha256 = "1vw70xfra52pycw9nhssnghbnm5nbji3487a5gv7zc3gr79xpn91";
  };

  allSSHKeys = builtins.readFile kioskAdminHunterSSHKeys;

  sshKeys = builtins.filter (s: s != "") (lib.splitString "\n" allSSHKeys);
in
{
  users.users = {
    jyupp = {
      createHome = true;
      extraGroups = ["wheel" "sudo"];
      group = "users";
      home = "/home/jyumpp";
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1001;
      isNormalUser = true;
      openssh.authorizedKeys.keys = sshKeys;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.edgeadmin = import ./jyumpp-home.nix;
}
