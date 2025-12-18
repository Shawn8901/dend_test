{ lib, ... }:
let
  inherit (lib)
    toInt
    removePrefix
    filter
    ;

  servePorts =
    zrepl:
    map (serveEntry: toInt (removePrefix ":" serveEntry.serve.listen)) (
      filter (builtins.hasAttr "serve") zrepl.settings.jobs
    );

  monitoringPort = 9811;
in
{
  cfg.zrepl.nixos =
    { config, pkgs, ... }:
    {
      networking.firewall.allowedTCPPorts = servePorts config.services.zrepl;
      services = {
        zrepl = {
          enable = true;
          settings.global.monitoring = [
            {
              type = "prometheus";
              listen = ":${toString monitoringPort}";
              listen_freebind = true;
            }
          ];
        };
        vmagent.prometheusConfig.scrape_configs = [
          {
            job_name = "zrepl";
            static_configs = [
              {
                targets = [
                  "localhost:${toString monitoringPort}"
                ];
              }
            ];
          }
        ];
      };
    };
}
