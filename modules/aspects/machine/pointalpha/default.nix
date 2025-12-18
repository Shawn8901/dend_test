{ __findFile, ... }:
{
  den.aspects.pointalpha = {
    includes = [
      <cfg/desktop>
      # <cfg/monitoree>
      # <cfg/remote-builder>
      # <cfg/shell>
      # <cfg/zfs>
      # <cfg/zrepl>
    ];
  };
}
