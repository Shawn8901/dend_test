{
  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
      vmBuilds = !pkgs.stdenvNoCC.isLinux || builtins.pathExists (self'.packages.vm + "/bin/vm");
    in
    {
      checks."vm builds" = checkCond "vm-builds" vmBuilds;
    };
}
