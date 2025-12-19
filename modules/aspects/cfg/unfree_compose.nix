{ lib, den, ... }:
let
  unfreeComposableModule.options.unfree = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };
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
          nixos.imports = [
            unfreeComposableModule
            (
              { config, ... }:
              {
                nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfree.packages;
              }
            )
          ];
          homeManager.imports = [
            unfreeComposableModule
            (
              { config, ... }:
              {
                nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.unfree.packages;
              }
            )
          ];
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
