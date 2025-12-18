{ cfg, ... }:
{
  cfg.monitoree.includes = with cfg.monitoree._; [
    vlagent
    vmagent
  ];
}
