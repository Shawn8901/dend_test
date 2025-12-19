{ lib, den, ... }:
let
  unfreeComposableModule.options.unfree = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  moduleImports = [
    unfreeComposableModule
    (
      { config, ... }:
      {
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfree.packages;
      }
    )
  ];

in
{
  den.provides.unfree_builder = den.lib.parametric.exactly {
    includes = [
      (
        { OS, host }:
        let
          unused = den.lib.take.unused OS;
        in
        {
          ${host.class}.imports = moduleImports;
        }
      )
      (
        {
          OS,
          HM,
          user,
          host,
        }:
        let
          unused = den.lib.take.unused [
            OS
            HM
          ];
        in
        {
          ${user.class}.imports = moduleImports;
        }
      )
      (
        { HM, home }:
        let
          unused = den.lib.take.unused HM;
        in
        {
          ${home.class}.imports = moduleImports;
        }
      )
    ];
  };

  den.provides.unfree_agg.__functor =
    _self: allowed-names:
    { class, aspect-chain }:
    den.lib.take.unused aspect-chain {
      ${class}.unfree.packages = allowed-names;
    };
}
