{ __findFile, ... }:
{
  cfg.desktop._.printer = {

    includes = [
      (<den/unfree_agg> [ "epsonscan2" ])
    ];

    nixos =
      { pkgs, ... }:
      {
        hardware.sane = {
          enable = true;
          extraBackends = [
            # (pkgs.epsonscan2.override {
            #   withNonFreePlugins = true;
            #   withGui = true;
            # })
          ];
        };

        services.printing = {
          enable = true;
          browsed.enable = false;
          listenAddresses = [ "localhost:631" ];
          drivers = [ pkgs.epson-escpr2 ];
        };

        environment.systemPackages = with pkgs.kdePackages; [
          print-manager
          skanlite
        ];
      };

  };
}
