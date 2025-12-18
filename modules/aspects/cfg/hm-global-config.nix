{ den, ... }:
{
  cfg.hm-global-config =
    { HM-OS-HOST }:
    den.lib.take.unused [ HM-OS-HOST.host ] {
      nixos.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
}
