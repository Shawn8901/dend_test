{ __findFile, ... }:
{
  den.aspects.pointalpha = {
    includes = [
      <cfg/desktop>
      <cfg/gaming>
      <cfg/monitoree>
      <cfg/perlless>
      <cfg/printer>
      <cfg/remote-builder>
      <cfg/zfs>
      <cfg/zrepl>
    ];
  };
}
