{
  cfg.zfs.nixos =
    { config, lib, ... }:
    {
      services = {
        zfs = {
          trim.enable = lib.mkDefault true;
          autoScrub.enable = true;
        };
        vmagent.prometheusConfig.scrape_configs = [
          {
            job_name = "zfs";
            static_configs = [
              { targets = [ "localhost:${toString config.services.prometheus.exporters.zfs.port}" ]; }
            ];
          }
        ];
      };
    };
}
