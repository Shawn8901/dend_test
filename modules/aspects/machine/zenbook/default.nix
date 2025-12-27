{ __findFile, ... }:
{
  den.aspects.zenbook = {
    includes = [
      <cfg/desktop>
      <cfg/monitoree>
      <cfg/shell>
      <cfg/zfs>
      <cfg/zrepl>
    ];
  };
}
