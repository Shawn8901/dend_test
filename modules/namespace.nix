{ inputs, den, ... }:
let
  inherit (inputs.den) namespace;
in
{
  imports = [
    (namespace "cfg" false)
    (namespace "shared" true)
  ];

  _module.args.__findFile = den.lib.__findFile;
}
