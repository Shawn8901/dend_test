{ __findFile, ... }:
{
  den.aspects.zenbook = {
    includes = [
      <cfg/desktop>
      <cfg/monitoree>
      <cfg/zfs>
      <cfg/zrepl>
    ];
  };
}
